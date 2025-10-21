import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shantika_cubit/utility/extensions/show_toast.dart';

import '../../../config/service_locator.dart';
import '../../../config/user_preference.dart';
import '../../../ui/color.dart';
import '../../../ui/dimension.dart';
import '../../../ui/shared_widget/custom_button.dart';
import '../../../ui/shared_widget/custom_text_form_field.dart';
import '../../../ui/typography.dart';
import '../../../utility/loading_overlay.dart';
import '../../navigation/navigation_screen.dart';
import '../login/login_screen.dart';
import 'cubit/change_password_cubit.dart';

// ignore: must_be_immutable
class ChangePasswordScreen extends StatefulWidget {
  final String email;
  ChangePasswordScreen({super.key, required this.email});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  ValueNotifier<bool> obscureTextPassword = ValueNotifier(true);
  ValueNotifier<bool> obscureTextConfirmPassword = ValueNotifier(true);

  final _key = GlobalKey<FormState>();

  @override
  void initState() {
    _passwordController.addListener(() {
      setState(() {});
    });

    _confirmPasswordController.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  late UserPreference _userPreference;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  late ChangePasswordCubit _changePasswordCubit;
  LoadingOverlay _overlay = LoadingOverlay();

  @override
  Widget build(BuildContext context) {
    _changePasswordCubit = context.read();
    _changePasswordCubit.init();

    _userPreference = serviceLocator.get<UserPreference>();

    return _buildMainView();
  }

  Widget _buildMainView() {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Anda Belum Mengubah Password'),
            content: Text('Anda yakin ingin kembali ?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Tidak'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Ya'),
              ),
            ],
          ),
        );
        return shouldPop ?? false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Kembali"),
        ),
        body: Form(
          key: _key,
          child: Padding(
            padding: const EdgeInsets.all(space400),
            child: BlocListener<ChangePasswordCubit, ChangePasswordState>(
              listener: (context, state) {
                if (state is ChangePasswordStateSuccess) {
                  _overlay.hide();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => _userPreference.getToken() != null ? NavigationScreen() : LoginScreen(),
                    ),
                    (route) => false,
                  );
                } else if (state is ChangePasswordStateError) {
                  _overlay.hide();
                  context.showCustomToast(
                    title: "Oopss",
                    message: state.message,
                    isSuccess: false,
                  );
                } else {
                  _overlay.show(context);
                }
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Buat Password Baru', style: lgSemiBold),
                    const SizedBox(height: 8),
                    Text(
                      'Password baru anda  harus berbeda dari password sebelumnya yang digunakan',
                      style: smRegular.copyWith(color: textDarkSecondary),
                    ),
                    const SizedBox(height: 20),
                    ValueListenableBuilder(
                      valueListenable: obscureTextPassword,
                      builder: (context, value, child) => CustomTextFormField(
                        obsecureText: value,
                        titleSection: 'Password',
                        keyboardType: TextInputType.text,
                        controller: _passwordController,
                        textInputAction: TextInputAction.done,
                        placeholder: 'Atur Password',
                        maxLines: 1,
                        validator: (e) => e.isEmpty ? "Tolong diisi terlebih dahulu" : null,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              obscureTextPassword.value = !obscureTextPassword.value;
                            },
                            child: SvgPicture.asset(
                              value ? 'assets/images/ic_eye_disabled.svg' : 'assets/images/ic_eye_enabled.svg',
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                      ),
                    ),
                    ValueListenableBuilder(
                      valueListenable: obscureTextConfirmPassword,
                      builder: (context, value, child) => CustomTextFormField(
                        obsecureText: value,
                        titleSection: 'Konfirmasi Password',
                        keyboardType: TextInputType.text,
                        controller: _confirmPasswordController,
                        textInputAction: TextInputAction.done,
                        placeholder: 'Atur Password',
                        maxLines: 1,
                        validator: (e) => e != _passwordController.text ? 'Password tidak sesuai' : null,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              obscureTextConfirmPassword.value = !obscureTextConfirmPassword.value;
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
                    CustomButton(
                      onPressed: _key.currentState?.validate() == true
                          ? () async {
                              if (_key.currentState!.validate()) {
                                _changePasswordCubit.changePassword(
                                  password: _passwordController.text,
                                  confirmPassword: _confirmPasswordController.text,
                                  email: widget.email,
                                );
                              }
                            }
                          : null,
                      child: const Text('Reset Password'),
                    ),
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
}
