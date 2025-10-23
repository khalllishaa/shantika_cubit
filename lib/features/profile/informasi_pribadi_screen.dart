import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shantika_cubit/ui/color.dart';
import 'package:shantika_cubit/ui/dimension.dart';
import 'package:shantika_cubit/ui/typography.dart';

import '../../ui/shared_widget/custom_button.dart';
import '../../ui/shared_widget/custom_text_form_field.dart';

class InformasiPribadiPage extends StatefulWidget {
  const InformasiPribadiPage({super.key});

  @override
  State<InformasiPribadiPage> createState() => _InformasiPribadiPageState();
}

class _InformasiPribadiPageState extends State<InformasiPribadiPage> {
  final _namaController = TextEditingController(text: "Anastasya Carolina");
  final _telpController = TextEditingController(text: "083745552724");
  final _emailController = TextEditingController(text: "anastasyacarolina@gmail.com");
  final _tempatLahirController = TextEditingController(text: "Semarang");
  final _tanggalLahirController = TextEditingController(text: "03 Oktober 2006");
  final _alamatController = TextEditingController(text: "Jl Sentiyaki Raya No 48, Semarang Utara");
  final ValueNotifier<String> selectedGender = ValueNotifier('Pria');

  @override
  void dispose() {
    _namaController.dispose();
    _telpController.dispose();
    _emailController.dispose();
    _tempatLahirController.dispose();
    _tanggalLahirController.dispose();
    _alamatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black00,
      appBar: _header(),
      body: Stack(
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
          SizedBox(height: spacing4),
          _buildGenderSelector(),
          SizedBox(height: spacing7),
          _buildTextField(
            title: "Alamat Lengkap",
            controller: _alamatController,
            maxLines: 5,
            validator: (val) => val?.isEmpty == true ? 'Alamat harus diisi' : null,
          ),        ],
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

  String _parseDateToApi(String dateStr) {
    try {
      final parts = dateStr.split('/');
      if (parts.length == 3) {
        final day = parts[0].padLeft(2, '0');
        final month = parts[1].padLeft(2, '0');
        final year = parts[2];
        return '$year-$month-$day';
      }
      return dateStr;
    } catch (e) {
      return dateStr;
    }
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
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius200),
              borderSide: BorderSide(color: primaryColor700),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius200),
              borderSide: BorderSide(color: primaryColor700, width: 2),
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

        },
        child: Text('Simpan'),
      ),
    );
  }

  Widget _profileSection(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/images/img_profil_default.jpg'),
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
                "Anastasya Carolina",
                style: mdMedium,
              ),
              SizedBox(height: space250),
              Row(
                children: [
                  Text(
                    "Member New Shantika",
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
                },
              ),
              ListTile(
                leading: Icon(Icons.photo),
                title: Text("From Files"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

}