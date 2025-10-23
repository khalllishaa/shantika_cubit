import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart'; // ✅ Import untuk SVG
import 'package:shantika_cubit/ui/dimension.dart';
import 'package:shantika_cubit/utility/extensions/email_validator_extension.dart';
import 'package:shantika_cubit/utility/extensions/show_toast.dart';

import '../../../config/constant.dart';
import '../../../ui/color.dart';
import '../../../ui/shared_widget/custom_button.dart';
import '../../../ui/shared_widget/custom_checkbox.dart';
import '../../../ui/shared_widget/custom_text_form_field.dart';
import '../../../ui/typography.dart';
import '../../../utility/loading_overlay.dart';
import '../../navigation/navigation_screen.dart';
import 'cubit/register_cubit.dart';
import 'package:uuid/uuid.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _birthPlaceController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _addressController = TextEditingController();
  final _idTypeController = TextEditingController();
  final _idNumberController = TextEditingController();

  final ValueNotifier<String> selectedGender = ValueNotifier('Pria');
  final ValueNotifier<bool> isAgreementChecked = ValueNotifier(false);

  final _key = GlobalKey<FormState>();
  final LoadingOverlay _overlay = LoadingOverlay();

  @override
  Widget build(BuildContext context) {
    final registerCubit = context.read<RegisterCubit>();
    registerCubit.init();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 60.5,
        leading: Padding(
          padding: EdgeInsets.only(left: padding16),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black, size: 20),
            onPressed: () => Navigator.pop(context),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ),
        titleSpacing: space500,
        title: Text(
          'Daftar',
          style: xlBold,
        ),
      ),
      body: Form(
        key: _key,
        child: BlocListener<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegisterStateLoading) {
              _overlay.show(context);
            } else if (state is RegisterStateSuccess) {
              _overlay.hide();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => NavigationScreen(),
                ),
                    (route) => false,
              );
            } else if (state is RegisterStateError) {
              _overlay.hide();
              context.showCustomToast(
                position: SnackBarPosition.top,
                title: "Oopss",
                message: state.message,
                isSuccess: false,
              );
            }
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: paddingL, vertical: space500),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFormField(
                  titleSection: 'Nama Lengkap',
                  maxLines: 1,
                  controller: _nameController,
                  validator: (val) => val?.isEmpty == true ? 'Nama lengkap harus diisi' : null,
                ),
                SizedBox(height: space400),

                CustomTextFormField(
                  titleSection: 'Nomor Telepon',
                  keyboardType: TextInputType.phone,
                  maxLines: 1,
                  controller: _phoneController,
                  validator: (val) => val?.isEmpty == true ? 'Nomor telepon harus diisi' : null,
                ),
                SizedBox(height: space400),

                CustomTextFormField(
                  titleSection: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  maxLines: 1,
                  controller: _emailController,
                  validator: (val) => val?.isValidEmail() == false ? 'Email tidak valid' : null,
                ),
                SizedBox(height: space400),

                Row(
                  children: [
                    // ✅ Tempat Lahir - pakai CustomTextFormField
                    Expanded(
                      child: CustomTextFormField(
                        titleSection: 'Tempat Lahir',
                        maxLines: 1,
                        controller: _birthPlaceController,
                        validator: (val) => val?.isEmpty == true ? 'Tempat lahir harus diisi' : null,
                      ),
                    ),
                    const SizedBox(width: 12),

                    // ✅ Tanggal Lahir - custom styled dengan SVG icon
                    Expanded(
                      child: _buildDateField(
                        label: 'Tanggal Lahir',
                        controller: _birthDateController,
                        context: context,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: space400),

                // Gender
                _buildGenderSelector(),
                SizedBox(height: space800),

                CustomTextFormField(
                  titleSection: 'Alamat Lengkap',
                  controller: _addressController,
                  maxLines: 3,
                  validator: (val) => val?.isEmpty == true ? 'Alamat harus diisi' : null,
                ),
                SizedBox(height: space400),

                CustomTextFormField(
                  titleSection: 'Jenis Kartu Identitas',
                  maxLines: 1,
                  controller: _idTypeController,
                  validator: (val) => val?.isEmpty == true ? 'Jenis kartu identitas harus diisi' : null,
                ),
                SizedBox(height: space400),

                CustomTextFormField(
                  titleSection: 'Nomor Kartu Identitas',
                  keyboardType: TextInputType.number,
                  maxLines: 1,
                  controller: _idNumberController,
                  validator: (val) => val?.isEmpty == true ? 'Nomor kartu identitas harus diisi' : null,
                ),
                SizedBox(height: space800),

                CustomButton(
                  onPressed: () {
                    if (_key.currentState?.validate() == true) {
                      final birthDate = _parseDateToApi(_birthDateController.text);
                      final uuid = const Uuid().v4();

                      registerCubit.register(
                        uuid: uuid,
                        name: _nameController.text,
                        email: _emailController.text,
                        phone: _phoneController.text,
                        birth: birthDate,
                        birthPlace: _birthPlaceController.text,
                        gender: selectedGender.value == 'Pria' ? 'Male' : 'Female',
                      );
                    }
                  },
                  child: Text('Daftar'),
                ),
                SizedBox(height: space800),
              ],
            ),
          ),
        ),
      ),
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
        RichText(
          text: TextSpan(
            text: label,
            style: smMedium.copyWith(color: textDarkPrimary),
            children: [
              TextSpan(
                text: ' *',
                style: TextStyle(color: primaryColor700),
              ),
            ],
          ),
        ),
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
}