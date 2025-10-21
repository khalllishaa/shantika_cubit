import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shantika_cubit/utility/extensions/email_validator_extension.dart';
import 'package:shantika_cubit/utility/extensions/show_toast.dart';

import '../../../config/constant.dart';
import '../../../ui/color.dart';
import '../../../ui/dimension.dart';
import '../../../ui/shared_widget/custom_button.dart';
import '../../../ui/shared_widget/custom_checkbox.dart';
import '../../../ui/shared_widget/custom_text_form_field.dart';
import '../../../ui/shared_widget/shadowed_button.dart';
import '../../../ui/typography.dart';
import '../../../utility/loading_overlay.dart';
import '../../navigation/navigation_screen.dart';
import '../login/login_screen.dart';
import 'cubit/register_cubit.dart';
// ignore: must_be_immutable
class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _firstNameController = TextEditingController();

  final _lastNameController = TextEditingController();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  ValueNotifier<bool> obscureText = ValueNotifier(false);

  ValueNotifier<bool> isAgreementChecked = ValueNotifier(false);

  final _key = GlobalKey<FormState>();

  late RegisterCubit _registerCubit;

  LoadingOverlay _overlay = LoadingOverlay();

  @override
  void initState() {
    _firstNameController.addListener(() {
      setState(() {});
    });

    _lastNameController.addListener(() {
      setState(() {});
    });

    _emailController.addListener(() {
      setState(() {});
    });

    _passwordController.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _lastNameController.dispose();
    _firstNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _registerCubit = context.read();
    _registerCubit.init();

    return _buildMainView();
  }

  Widget _buildMainView() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _key,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(space400),
            child: SingleChildScrollView(
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
                        (route) => false);
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Selamat Datang!', style: xsMedium),
                    const SizedBox(height: space150),
                    const Text('Daftarkan Sekarang', style: lgSemiBold),
                    const SizedBox(height: 36),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: space400),
                        Image.asset(
                          'assets/images/img_new_auth.png',
                          height: 224,
                          width: 299,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            titleSection: 'Nama Depan',
                            keyboardType: TextInputType.text,
                            maxLines: 1,
                            controller: _firstNameController,
                            placeholder: 'Masukan Nama',
                            validator: (input) => input.isNotEmpty ? null : "Nama depan harus diisi",
                          ),
                        ),
                        const SizedBox(width: space400),
                        Expanded(
                          child: CustomTextFormField(
                            titleSection: 'Nama Belakang',
                            keyboardType: TextInputType.text,
                            maxLines: 1,
                            controller: _lastNameController,
                            placeholder: 'Masukan Nama',
                            validator: (input) => input.isNotEmpty ? null : "Nama belakang harus diisi",
                          ),
                        ),
                      ],
                    ),
                    CustomTextFormField(
                      titleSection: 'Email',
                      keyboardType: TextInputType.text,
                      maxLines: 1,
                      controller: _emailController,
                      placeholder: 'Masukan email anda',
                      validator: (input) => input.isValidEmail() ? null : "Email tidak valid",
                    ),
                    ValueListenableBuilder(
                      valueListenable: obscureText,
                      builder: (context, value, child) => CustomTextFormField(
                        obsecureText: value,
                        titleSection: 'Password',
                        keyboardType: TextInputType.text,
                        controller: _passwordController,
                        textInputAction: TextInputAction.done,
                        placeholder: 'Masukan Password',
                        maxLines: 1,
                        validator: (e) => e.isEmpty ? "Tolong diisi terlebih dahulu" : null,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              obscureText.value = !obscureText.value;
                            },
                            child: SvgPicture.asset(
                              value ? 'assets/images/ic_eye_disabled.svg' : 'assets/images/ic_eye_enabled.svg',
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: space300),
                    _buildTermsAndConditionView(),
                    const SizedBox(height: space300),
                    CustomButton(
                      onPressed: (_key.currentState?.validate() == true) && isAgreementChecked.value
                          ? () {
                              if (_key.currentState!.validate()) {
                                _registerCubit.register(
                                  firstName: _firstNameController.text,
                                  lastName: _lastNameController.text,
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  confirmPassword: _passwordController.text,
                                );
                              }
                            }
                          : null,
                      child: const Text('Daftar'),
                    ),
                    const SizedBox(height: space400 + 1),
                    _buildDividerView(),
                    const SizedBox(height: space400 + 1),
                    _buildOtherMethodLoginView(),
                    const SizedBox(height: space800),
                    _buildHaveAnAccountView(),
                    const SizedBox(height: space800),
                    const SizedBox(height: space800),
                    const SizedBox(height: space800),
                    const SizedBox(height: space800),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row _buildTermsAndConditionView() {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: isAgreementChecked,
          builder: (context, value, child) => CustomCheckbox(
            value: value,
            onChanged: (e) {
              isAgreementChecked.value = e;
              setState(() {});
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            'Dengan mendaftar, Anda menyetujui Syarat & Ketentuan serta Kebijakan Privasi dari GARDA',
            style: smRegular.copyWith(color: textDarkPrimary),
            textAlign: TextAlign.start,
            // maxLines: 2,
            // overflow: TextOverflow.ellipsis,
          ),
        )
        // Text.rich(
        //   overflow: TextOverflow.visible,
        //   TextSpan(
        //     style: smRegular,
        //     text: 'Saya menyetujui Syarat & Ketentuan\n',
        //     children: <InlineSpan>[
        //       TextSpan(
        //         text: 'Dengan mendaftar, Anda menyetujui Syarat &\nKetentuan serta Kebijakan Privasi yang berlaku.',
        //         style: smRegular.copyWith(color: textDarkSecondary),
        //       )
        //     ],
        //   ),
        // ),
      ],
    );
  }

  Widget _buildHaveAnAccountView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Sudah punya akun?', style: smRegular),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
          },
          child: Text(
            ' Masuk',
            style: smRegular.copyWith(color: primaryColor),
          ),
        ),
      ],
    );
  }

  Widget _buildOtherMethodLoginView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ShadowedButton(
          onPressed: () {
            _registerCubit.registerWithGoogle();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/images/ic_google.svg'),
              const SizedBox(width: space150),
              const Text('Continue With Google', style: mdMedium),
            ],
          ),
        ),
        const SizedBox(height: space400),
        Visibility(
          visible: Platform.isIOS,
          child: ShadowedButton(
            onPressed: () {
              _registerCubit.registerWithApple();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/images/ic_apple.svg'),
                const SizedBox(width: space150),
                const Text('Continue With Apple', style: mdMedium),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDividerView() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: borderNeutralLight.withOpacity(0.10),
          ),
        ),
        const SizedBox(width: space150),
        const Text('Atau', style: xsRegular),
        const SizedBox(width: space150),
        Expanded(
          child: Container(
            height: 1,
            color: borderNeutralLight.withOpacity(0.10),
          ),
        ),
      ],
    );
  }
}
