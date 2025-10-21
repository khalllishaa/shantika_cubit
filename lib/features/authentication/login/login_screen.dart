import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nested/nested.dart';
import 'package:shantika_cubit/utility/extensions/email_validator_extension.dart';
import 'package:shantika_cubit/utility/extensions/show_toast.dart';

import '../../../config/constant.dart';
import '../../../ui/color.dart';
import '../../../ui/dimension.dart';
import '../../../ui/shared_widget/custom_button.dart';
import '../../../ui/shared_widget/custom_text_form_field.dart';
import '../../../ui/shared_widget/shadowed_button.dart';
import '../../../ui/typography.dart';
import '../../../utility/loading_overlay.dart';
import '../../navigation/navigation_screen.dart';
import '../password/forgot_password_screen.dart';
import '../register/register_screen.dart';
import 'cubit/login_apple_cubit.dart';
import 'cubit/login_email_cubit.dart';
import 'cubit/login_google_cubit.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  ValueNotifier<bool> obscureText = ValueNotifier(false);

  final _key = GlobalKey<FormState>();

  late LoginEmailCubit _loginEmailCubit;
  late LoginGoogleCubit _loginGoogleCubit;
  late LoginAppleCubit _loginAppleCubit;

  LoadingOverlay _overlay = LoadingOverlay();

  @override
  void initState() {
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _loginEmailCubit = context.read();
    _loginEmailCubit.init();

    _loginGoogleCubit = context.read();
    _loginGoogleCubit.init();

    _loginAppleCubit = context.read();
    _loginAppleCubit.init();

    return _buildMainView();
  }

  Widget _buildMainView() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _key,
        child: SafeArea(
          child: MultiBlocListener(
            listeners: _loginListener,
            child: Padding(
              padding: const EdgeInsets.all(space400),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Selamat Datang!', style: xsMedium),
                    const SizedBox(height: space150),
                    const Text('Masuk Sekarang', style: lgSemiBold),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                            );
                          },
                          child: Text(
                            'Lupa Password',
                            style: smRegular.copyWith(
                              color: textInfo,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: space300),
                    CustomButton(
                      onPressed: _key.currentState?.validate() == true
                          ? () {
                              if (_key.currentState!.validate()) {
                                _loginEmailCubit.login(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
                              }
                            }
                          : null,
                      child: const Text('Masuk'),
                    ),
                    const SizedBox(height: space400 + 1),
                    _buildDividerView(),
                    const SizedBox(height: space400 + 1),
                    _buildOtherMethodLoginView(),
                    const SizedBox(height: space800),
                    _buildDontHaveAccountView(),
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

  List<SingleChildWidget> get _loginListener {
    return [
      BlocListener<LoginEmailCubit, LoginEmailState>(
        listener: (context, state) {
          if (state is LoginStateEmailSuccess) {
            _overlay.hide();

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => NavigationScreen(),
                ),
                (route) => false);
          } else if (state is LoginStateEmailError) {
            _overlay.hide();

            context.showCustomToast(
              position: SnackBarPosition.top,
              title: "Error",
              message: state.message,
              isSuccess: false,
            );
          } else {
            _overlay.show(context);
          }
        },
      ),
      BlocListener<LoginGoogleCubit, LoginGoogleState>(
        listener: (context, state) {
          if (state is LoginGoogleStateSuccess) {
            _overlay.hide();

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => NavigationScreen(),
                ),
                (route) => false);
          } else if (state is LoginGoogleStateError) {
            _overlay.hide();
            debugPrint(state.message);

            context.showCustomToast(
              position: SnackBarPosition.top,
              title: "Error",
              message: state.message,
              isSuccess: false,
            );
          } else {
            _overlay.show(context);
          }
        },
      ),
      BlocListener<LoginAppleCubit, LoginAppleState>(
        listener: (context, state) {
          if (state is LoginAppleStateSuccess) {
            _overlay.hide();

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => NavigationScreen(),
                ),
                (route) => false);
          } else if (state is LoginAppleStateError) {
            _overlay.hide();
            context.showCustomToast(
              position: SnackBarPosition.top,
              title: "Error",
              message: state.message,
              isSuccess: false,
            );
          } else {
            _overlay.show(context);
          }
        },
      ),
    ];
  }

  Widget _buildDontHaveAccountView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Belum punya akun?', style: smRegular),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegisterScreen()),
            );
          },
          child: Text(
            ' Daftar',
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
            _loginGoogleCubit.loginGoogle();
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
              _loginAppleCubit.loginApple();
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
