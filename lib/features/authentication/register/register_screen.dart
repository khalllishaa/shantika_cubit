import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shantika_cubit/utility/extensions/email_validator_extension.dart';
import 'package:shantika_cubit/utility/extensions/show_toast.dart';

import '../../../config/constant.dart';
import '../../../ui/color.dart';
import '../../../ui/shared_widget/custom_button.dart';
import '../../../ui/shared_widget/custom_checkbox.dart';
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
          padding: const EdgeInsets.only(left: 27.5),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black, size: 20),
            onPressed: () => Navigator.pop(context),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ),
        titleSpacing: 33,
        title: const Text(
          'Daftar',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nama Lengkap
                _buildTextField(
                  label: 'Nama Lengkap',
                  controller: _nameController,
                  validator: (val) => val?.isEmpty == true ? 'Nama lengkap harus diisi' : null,
                ),
                const SizedBox(height: 16),

                // Nomor Telepon
                _buildTextField(
                  label: 'Nomor Telepon',
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  validator: (val) => val?.isEmpty == true ? 'Nomor telepon harus diisi' : null,
                ),
                const SizedBox(height: 16),

                // Email
                _buildTextField(
                  label: 'Email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) => val?.isValidEmail() == false ? 'Email tidak valid' : null,
                ),
                const SizedBox(height: 16),

                // Tempat & Tanggal Lahir
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        label: 'Tempat Lahir',
                        controller: _birthPlaceController,
                        validator: (val) => val?.isEmpty == true ? 'Tempat lahir harus diisi' : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildDateField(
                        label: 'Tanggal Lahir',
                        controller: _birthDateController,
                        context: context,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Gender
                _buildGenderSelector(),
                const SizedBox(height: 16),

                // Alamat Lengkap
                _buildTextField(
                  label: 'Alamat Lengkap',
                  controller: _addressController,
                  maxLines: 3,
                  validator: (val) => val?.isEmpty == true ? 'Alamat harus diisi' : null,
                ),
                const SizedBox(height: 16),

                // Jenis Kartu Identitas
                _buildTextField(
                  label: 'Jenis Kartu Identitas',
                  controller: _idTypeController,
                  validator: (val) => val?.isEmpty == true ? 'Jenis kartu identitas harus diisi' : null,
                ),
                const SizedBox(height: 16),

                // Nomor Kartu Identitas
                _buildTextField(
                  label: 'Nomor Kartu Identitas',
                  controller: _idNumberController,
                  keyboardType: TextInputType.number,
                  validator: (val) => val?.isEmpty == true ? 'Nomor kartu identitas harus diisi' : null,
                ),
                const SizedBox(height: 24),

                // Terms & Conditions Checkbox
                _buildTermsAndConditionView(),
                const SizedBox(height: 24),

                // Register Button
                ValueListenableBuilder(
                  valueListenable: isAgreementChecked,
                  builder: (context, isChecked, _) {
                    return CustomButton(
                        onPressed: isChecked
                            ? () {
                          if (_key.currentState?.validate() == true) {
                            final birthDate = _parseDateToApi(_birthDateController.text);

                            // 🔹 Generate UUID unik
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
                        }
                        : null,
                      child: const Text('Daftar'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper function untuk convert tanggal dari DD/MM/YYYY ke YYYY-MM-DD
  String _parseDateToApi(String dateStr) {
    try {
      final parts = dateStr.split('/');
      if (parts.length == 3) {
        final day = parts[0].padLeft(2, '0');
        final month = parts[1].padLeft(2, '0');
        final year = parts[2];
        return '$year-$month-$day'; // Format: YYYY-MM-DD
      }
      return dateStr;
    } catch (e) {
      return dateStr;
    }
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF1F2937),
              fontWeight: FontWeight.w500,
            ),
            children: const [
              TextSpan(
                text: ' *',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
          ),
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
        RichText(
          text: TextSpan(
            text: label,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF1F2937),
              fontWeight: FontWeight.w500,
            ),
            children: const [
              TextSpan(
                text: ' *',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
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
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            suffixIcon: const Icon(Icons.calendar_today, size: 20, color: Color(0xFF9CA3AF)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red),
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
        const Text(
          'Gender',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF1F2937),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        ValueListenableBuilder(
          valueListenable: selectedGender,
          builder: (context, gender, _) {
            return Row(
              children: [
                Expanded(
                  child: _buildGenderOption('Pria', gender == 'Pria'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildGenderOption('Wanita', gender == 'Wanita'),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildGenderOption(String label, bool isSelected) {
    return GestureDetector(
      onTap: () => selectedGender.value = label,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E3A8A) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? const Color(0xFF1E3A8A) : const Color(0xFFE5E7EB),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? Colors.white : const Color(0xFFE5E7EB),
              ),
              child: Center(
                child: Icon(
                  label == 'Pria' ? Icons.male : Icons.female,
                  size: 14,
                  color: isSelected ? const Color(0xFF1E3A8A) : const Color(0xFF6B7280),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : const Color(0xFF1F2937),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTermsAndConditionView() {
    return ValueListenableBuilder(
      valueListenable: isAgreementChecked,
      builder: (context, isChecked, _) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomCheckbox(
              value: isChecked,
              onChanged: (value) {
                isAgreementChecked.value = value;
              },
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Dengan mendaftar, Anda menyetujui Syarat & Ketentuan serta Kebijakan Privasi dari New Shantika',
                style: smRegular.copyWith(color: textDarkPrimary),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        );
      },
    );
  }
}