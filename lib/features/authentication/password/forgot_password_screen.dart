import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shantika_cubit/utility/extensions/email_validator_extension.dart';
import 'package:shantika_cubit/utility/extensions/show_toast.dart';

import '../../../ui/color.dart';
import '../../../ui/dimension.dart';
import '../../../ui/shared_widget/custom_button.dart';
import '../../../ui/shared_widget/custom_text_form_field.dart';
import '../../../ui/typography.dart';
import '../../../utility/lifecycle_handler.dart';
import '../../../utility/loading_overlay.dart';
import 'change_password_screen.dart';
import 'cubit/send_to_email_cubit.dart';
import 'cubit/validate_reset_token_cubit.dart';

// ignore: must_be_immutable
class ForgotPasswordScreen extends StatefulWidget {
  ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends LifecycleHandler<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _tokenController = TextEditingController();

  late SendToEmailCubit _sendToEmailCubit;
  late ValidateResetTokenCubit _validateResetTokenCubit;

  LoadingOverlay _overlay = LoadingOverlay();

  final _key = GlobalKey<FormState>();

  ValueNotifier<bool> isOtpFieldShow = ValueNotifier(false);

  @override
  void initState() {
    _emailController.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _sendToEmailCubit = context.read();
    _sendToEmailCubit.init();

    _validateResetTokenCubit = context.read();
    _validateResetTokenCubit.init();

    return _buildMainView();
  }

  Widget _buildMainView() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Kembali"),
      ),
      body: Form(
        key: _key,
        child: Padding(
          padding: const EdgeInsets.all(space400),
          child: MultiBlocListener(
            listeners: [
              BlocListener<SendToEmailCubit, SendToEmailState>(
                listener: (context, state) {
                  if (state is SendToEmailStateSuccess) {
                    _overlay.hide();
                    isOtpFieldShow.value = true;
                  } else if (state is SendToEmailStateError) {
                    _overlay.hide();
                    context.showCustomToast(title: "Oops!!", message: state.message, isSuccess: false);
                  } else {
                    _overlay.show(context);
                  }
                },
              ),
              BlocListener<ValidateResetTokenCubit, ValidateResetTokenState>(
                listener: (context, state) {
                  if (state is ValidateResetTokenStateSuccess) {
                    _overlay.hide();
                    isOtpFieldShow.value = false;
                    _tokenController.clear();
                    _emailController.clear();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangePasswordScreen(
                          email: state.email,
                        ),
                      ),
                    );
                  } else if (state is ValidateResetTokenStateError) {
                    _overlay.hide();
                    context.showCustomToast(title: "Oops!!", message: state.message, isSuccess: false);
                  } else {
                    _overlay.show(context);
                  }
                },
              ),
            ],
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Reset Password', style: lgSemiBold),
                  const SizedBox(height: 8),
                  Text(
                    'Masukkan email yang terhubung dengan akun Anda, dan kami akan mengirimkan email berisi instruksi untuk mengatur ulang kata sandi Anda.',
                    style: smRegular.copyWith(color: textDarkSecondary),
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    titleSection: 'Email',
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    controller: _emailController,
                    placeholder: 'Masukan email yang terdaftar',
                    validator: (input) => input.isValidEmail() ? null : "Email tidak valid",
                  ),
                  ValueListenableBuilder(
                    valueListenable: isOtpFieldShow,
                    builder: (context, value, child) => Visibility(
                      visible: value,
                      child: CustomTextFormField(
                        titleSection: 'Token',
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        controller: _tokenController,
                        placeholder: 'Masukan token yang didapat dari email',
                      ),
                    ),
                  ),
                  const SizedBox(height: space300),
                  Visibility(
                    visible: !(isOtpFieldShow.value),
                    child: CustomButton(
                      onPressed: _key.currentState?.validate() == true
                          ? () {
                              if (_key.currentState!.validate()) {
                                _sendToEmailCubit.sendToEmail(email: _emailController.text);
                              }
                            }
                          : null,
                      child: const Text('Kirim Email'),
                    ),
                  ),
                  SizedBox(height: space300),
                  ValueListenableBuilder(
                    valueListenable: isOtpFieldShow,
                    builder: (context, value, child) => Visibility(
                      visible: value,
                      child: CustomButton(
                        onPressed: () {
                          _validateResetTokenCubit.validateResetToken(
                            email: _emailController.text,
                            token: _tokenController.text,
                          );
                        },
                        child: const Text('Reset Password'),
                      ),
                    ),
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
    );
  }

  @override
  void onDetached() {
    print("Detached");
  }

  @override
  void onInactive() {
    print("Innactived");
  }

  @override
  void onPaused() {
    print("ONPAUSED");
  }

  @override
  void onResumed() {
    print("ONRESUMED");
  }
}
