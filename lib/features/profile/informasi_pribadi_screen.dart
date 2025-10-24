import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shantika_cubit/ui/color.dart';
import 'package:shantika_cubit/ui/dimension.dart';
import 'package:shantika_cubit/ui/typography.dart';
import 'package:shantika_cubit/utility/extensions/show_toast.dart';
import 'package:shantika_cubit/utility/loading_overlay.dart';

import '../../config/constant.dart';
import '../../ui/shared_widget/custom_button.dart';
import '../../ui/shared_widget/custom_text_form_field.dart';
import '../profile/cubit/profile_cubit.dart';

class InformasiPribadiPage extends StatefulWidget {
  const InformasiPribadiPage({super.key});

  @override
  State<InformasiPribadiPage> createState() => _InformasiPribadiPageState();
}

class _InformasiPribadiPageState extends State<InformasiPribadiPage> {
  final _namaController = TextEditingController();
  final _telpController = TextEditingController();
  final _emailController = TextEditingController();
  final _tempatLahirController = TextEditingController();
  final _tanggalLahirController = TextEditingController();
  final _alamatController = TextEditingController();
  final ValueNotifier<String> selectedGender = ValueNotifier('Pria');

  final loadingOverlay = LoadingOverlay();
  String? avatarUrl;
  bool _isDataPopulated = false; // ✅ Flag untuk cek apakah data sudah di-populate

  @override
  void initState() {
    super.initState();
    // ✅ Cek state saat ini, jika sudah ada data langsung populate
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentState = context.read<ProfileCubit>().state;
      if (currentState is ProfileStateSuccess) {
        _populateData(currentState);
      } else {
        // Jika belum ada data, panggil API
        context.read<ProfileCubit>().profile();
      }
    });
  }

  @override
  void dispose() {
    _namaController.dispose();
    _telpController.dispose();
    _emailController.dispose();
    _tempatLahirController.dispose();
    _tanggalLahirController.dispose();
    _alamatController.dispose();
    selectedGender.dispose();
    super.dispose();
  }

  void _populateData(ProfileStateSuccess state) {
    if (_isDataPopulated) return;

    final user = state.user;

    // Data yang pasti ada dari response
    _namaController.text = user.name ?? '';
    _telpController.text = user.phone ?? '';

    // Data yang mungkin ada
    _emailController.text = user.email ?? '';
    _tempatLahirController.text = user.birthPlace ?? '';
    _alamatController.text = user.address ?? '';

    // Format birth date dari DateTime ke string
    if (user.birth != null) {
      _tanggalLahirController.text =
      '${user.birth!.day.toString().padLeft(2, '0')}/${user.birth!.month.toString().padLeft(2, '0')}/${user.birth!.year}';
    }

    avatarUrl = user.avatarUrl;

    // Set gender jika ada
    if (user.gender != null) {
      if (user.gender!.toLowerCase() == 'male' ||
          user.gender!.toLowerCase() == 'laki-laki' ||
          user.gender!.toLowerCase() == 'pria') {
        selectedGender.value = 'Pria';
      } else if (user.gender!.toLowerCase() == 'female' ||
          user.gender!.toLowerCase() == 'perempuan' ||
          user.gender!.toLowerCase() == 'wanita') {
        selectedGender.value = 'Wanita';
      }
    }

    _isDataPopulated = true; // ✅ Tandai sudah di-populate

    debugPrint('✅ Data populated - Name: ${user.name}, Phone: ${user.phone}, Email: ${user.email}');
    debugPrint('✅ Birth: ${user.birth}, BirthPlace: ${user.birthPlace}, Gender: ${user.gender}, Address: ${user.address}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black00,
      appBar: _header(),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileStateLoading) {
            loadingOverlay.show(context);
          } else {
            loadingOverlay.hide();
          }

          if (state is ProfileStateError) {
            context.showCustomToast(
              position: SnackBarPosition.top,
              title: "Error",
              message: state.message,
              isSuccess: false,
            );
          }

          // ✅ Populate data di listener
          if (state is ProfileStateSuccess) {
            _populateData(state);
          }
        },
        builder: (context, state) {
          // ✅ Juga populate di builder untuk ensure data tampil
          if (state is ProfileStateSuccess && !_isDataPopulated) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _populateData(state);
            });
          }

          return Stack(
            children: [
              SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 100),
                  child: _content(),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: _bottomSection(),
              ),
            ],
          );
        },
      ),
    );
  }

  PreferredSizeWidget _header() {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight + 4),
      child: Container(
        decoration: BoxDecoration(
          color: black00,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: black950),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "Informasi Pribadi",
            style: xlMedium,
          ),
        ),
      ),
    );
  }

  Widget _content() {
    return Padding(
      padding: EdgeInsets.all(padding20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: spacing3),
          _profileSection(context),
          SizedBox(height: spacing8),

          // Nama Lengkap
          CustomTextFormField(
            titleSection: "Nama Lengkap",
            controller: _namaController,
          ),
          SizedBox(height: spacing5),

          // Nomor Telepon
          CustomTextFormField(
            titleSection: "Nomor Telepon",
            controller: _telpController,
            keyboardType: TextInputType.phone,
          ),
          SizedBox(height: spacing5),

          // Email
          CustomTextFormField(
            titleSection: "Email",
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: spacing5),

          // Tempat dan Tanggal Lahir
          Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  titleSection: 'Tempat Lahir',
                  maxLines: 1,
                  controller: _tempatLahirController,
                  validator: (val) => val?.isEmpty == true ? 'Tempat lahir harus diisi' : null,
                ),
              ),
              SizedBox(width: spacing4),

              Expanded(
                child: _buildDateField(
                  label: 'Tanggal Lahir',
                  controller: _tanggalLahirController,
                  context: context,
                ),
              ),
            ],
          ),
          SizedBox(height: spacing5),
          _buildGenderSelector(),
          SizedBox(height: spacing5),
          _buildTextField(
            title: "Alamat Lengkap",
            controller: _alamatController,
            hintText: "Masukkan alamat lengkap",
            maxLines: 5,
            validator: (val) => val?.isEmpty == true ? 'Alamat harus diisi' : null,
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String title,
    required TextEditingController controller,
    String? hintText,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: smMedium.copyWith(fontWeight: FontWeight.w500),
        ),
        SizedBox(height: space250),
        TextFormField(
          controller: controller,
          validator: validator,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: xsMedium.copyWith(color: black300),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: maxLines > 1 ? 16 : 12,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius300),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius300),
              borderSide: BorderSide(color: Colors.grey.shade400, width: 1.2),
            ),
          ),
          style: xsMedium.copyWith(color: black900),
        ),
      ],
    );
  }

  Widget _buildDateField({
    required String label,
    required TextEditingController controller,
    required BuildContext context,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Tanggal Lahir', style: smMedium.copyWith(fontWeight: FontWeight.w500)),
        SizedBox(height: space200),
        TextFormField(
          controller: controller,
          readOnly: true,
          validator: (val) => val?.isEmpty == true ? 'Tanggal lahir harus diisi' : null,
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now().subtract(const Duration(days: 365 * 17)),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (date != null) {
              controller.text = '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
            }
          },
          style: smRegular,
          decoration: InputDecoration(
            hintText: "Pilih tanggal lahir",
            hintStyle: xsMedium.copyWith(color: black300),
            filled: true,
            fillColor: shimmerHighlightColor,
            contentPadding: EdgeInsets.symmetric(horizontal: padding16, vertical: spacing4),
            suffixIcon: Padding(
              padding: EdgeInsets.all(spacing4),
              child: SvgPicture.asset(
                'assets/images/ic_calendar.svg',
                width: iconM,
                colorFilter: ColorFilter.mode(black500, BlendMode.srcIn),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius200),
              borderSide: BorderSide(color: borderNeutralLight),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius200),
              borderSide: BorderSide(color: borderNeutralLight),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius200),
              borderSide: BorderSide(color: primaryColor, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gender',
          style: smMedium.copyWith(color: textDarkPrimary),
        ),
        SizedBox(height: space300),
        ValueListenableBuilder(
          valueListenable: selectedGender,
          builder: (context, gender, _) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: paddingS, vertical: paddingS),
              decoration: BoxDecoration(
                color: shimmerHighlightColor,
                borderRadius: BorderRadius.circular(borderRadius200),
                border: Border.all(color: borderNeutralLight),
              ),
              child: Row(
                children: [
                  _buildGenderOption('Pria', gender == 'Pria'),
                  SizedBox(width: space800),
                  _buildGenderOption('Wanita', gender == 'Wanita'),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildGenderOption(String label, bool isSelected) {
    return GestureDetector(
      onTap: () => selectedGender.value = label,
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? textButtonSecondaryPressed : black500,
            ),
            child: Center(
              child: Icon(
                label == 'Pria' ? Icons.male : Icons.female,
                size: 18,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: space250),
          Text(
            label,
            style: smMedium.copyWith(
              color: isSelected ? textButtonSecondaryPressed : black500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomSection() {
    return Container(
      padding: EdgeInsets.all(padding16),
      decoration: BoxDecoration(
        color: black00,
        boxShadow: [
          BoxShadow(
            color: black950.withOpacity(0.08),
            blurRadius: 8,
            offset: Offset(0, -3),
          ),
        ],
      ),
      child: CustomButton(
        onPressed: () {
          // TODO: Implement update profile
          context.showCustomToast(
            position: SnackBarPosition.top,
            title: "Info",
            message: "Fitur update akan segera ditambahkan",
            isSuccess: true,
          );
        },
        child: Text('Simpan'),
      ),
    );
  }

  Widget _profileSection(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        String name = "User";
        String memberStatus = "Member New Shantika";

        if (state is ProfileStateSuccess) {
          name = state.user.name ?? "User";
        }

        return Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: avatarUrl != null && avatarUrl!.isNotEmpty
                      ? NetworkImage(avatarUrl!)
                      : AssetImage('assets/images/img_profil_default.jpg') as ImageProvider,
                  backgroundColor: black600,
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: black950.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        _showImagePickerBottomSheet(context);
                      },
                      child: SvgPicture.asset('assets/images/ic_camera.svg'),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: space600),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: mdMedium,
                  ),
                  SizedBox(height: space250),
                  Row(
                    children: [
                      Text(
                        memberStatus,
                        style: smMedium.copyWith(color: black700_70),
                      ),
                      SizedBox(width: space100),
                      SvgPicture.asset(
                        "assets/icons/check_filled.svg",
                        width: 16,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _showImagePickerBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text("From Camera"),
                onTap: () {
                  Navigator.pop(context);
                  context.showCustomToast(
                    position: SnackBarPosition.top,
                    title: "Info",
                    message: "Fitur kamera akan segera ditambahkan",
                    isSuccess: true,
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.photo),
                title: Text("From Files"),
                onTap: () {
                  Navigator.pop(context);
                  context.showCustomToast(
                    position: SnackBarPosition.top,
                    title: "Info",
                    message: "Fitur pilih file akan segera ditambahkan",
                    isSuccess: true,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}