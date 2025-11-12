import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nested/nested.dart';
import 'package:shantika_cubit/features/authentication/login/cubit/login_phone_cubit.dart';
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
// import 'cubit/login_apple_cubit.dart';
// import 'cubit/login_email_cubit.dart';
// import 'cubit/login_google_cubit.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _phoneController = TextEditingController();
  final _key = GlobalKey<FormState>();
  final LoadingOverlay _overlay = LoadingOverlay();

  @override
  Widget build(BuildContext context) {
    final loginPhoneCubit = context.read<LoginPhoneCubit>()..init();
    // final loginGoogleCubit = context.read<LoginGoogleCubit>()..init();

    return Scaffold(
      body: Stack(
        children: [
          _buildBackgroundImage(),

          SafeArea(
            child: Form(
              key: _key,
              child: MultiBlocListener(
                listeners: _buildLoginListeners(context, _overlay),
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: _buildLogoSection(),
                    ),
                    Expanded(
                      flex: 3,
                      child: _buildLoginFormSection(
                        context,
                        loginPhoneCubit,
                        // loginGoogleCubit,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return Transform.rotate(
      angle: 3.1416,
      alignment: Alignment.center,
      child: Container(
        height: 426,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/img_banner_shantika.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              secondaryColor_60,
              BlendMode.darken,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoSection() {
    return Center(
      child: Image.asset(
        'assets/images/img_logo_shantika.png',
        width: 280,
        height: 200,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildLoginFormSection(
      BuildContext context,
      LoginPhoneCubit loginPhoneCubit,
      // LoginGoogleCubit loginGoogleCubit,
      ) {
    return Container(
      decoration: BoxDecoration(
        color: black00,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius750),
          topRight: Radius.circular(borderRadius750),
        ),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(top: paddingXL, left: paddingL, right: paddingL, bottom: paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Selamat Datang',
              style: lgBold,
            ),
            Text(
              'di Aplikasi Customer New Shantika',
              style: lgBold,
            ),
            SizedBox(height: space500),

            CustomTextFormField(
              titleSection: 'Nomor Telepon',
              keyboardType: TextInputType.phone,
              maxLines: 1,
              controller: _phoneController,
              placeholder: '',
              validator: (input) =>
              input?.isEmpty == true ? "Nomor telepon tidak boleh kosong" : null,
            ),
            SizedBox(height: space600),

            CustomButton(
              onPressed: () {
                if (_key.currentState!.validate()) {
                  loginPhoneCubit.login(phone: _phoneController.text);
                }
              },
              padding: EdgeInsets.symmetric(vertical: padding16),
              child: Text('Masuk'),
              backgroundColor: primaryColor,
            ),

            SizedBox(height: space400),
            _buildDivider(),
            SizedBox(height: space500),
            ShadowedButton(
              onPressed: () {
                // loginGoogleCubit.loginGoogle();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/images/ic_google.svg'),
                  SizedBox(width: space250),
                  Text('masuk dengan google', style: smSemiBold),
                ],
              ),
            ),
            SizedBox(height: space400),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'belum punya akun? ',
                  style: smMedium.copyWith(color: black500),
                ),
                SizedBox(width: space050),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: Text(
                    'Daftar',
                    style: smSemiBold.copyWith(
                      color: primaryColor,
                    ),
                  ),
                ),
                SizedBox(width: space050),
                Text(
                  ' sekarang',
                  style: smMedium.copyWith(color: black500),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: borderNeutralLight.withOpacity(0.10),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: padding16),
          child: Text(
            'atau masuk dengan google',
            style: smMedium.copyWith(color: black500),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: borderNeutralLight.withOpacity(0.10),
          ),
        ),
      ],
    );
  }

  List<SingleChildWidget> _buildLoginListeners(
      BuildContext context,
      LoadingOverlay overlay,
      ) {
    return [
      BlocListener<LoginPhoneCubit, LoginPhoneState>(
        listener: (context, state) {
          if (state is LoginPhoneStateSuccess) {
            overlay.hide();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => NavigationScreen()),
                  (route) => false,
            );
          } else if (state is LoginPhoneStateError) {
            overlay.hide();
            context.showCustomToast(
              position: SnackBarPosition.top,
              title: "Error",
              message: state.message,
              isSuccess: false,
            );
          } else if (state is LoginPhoneStateLoading) {
            overlay.show(context);
          }
        },
      ),

      // BlocListener<LoginGoogleCubit, LoginGoogleState>(
      //   listener: (context, state) {
      //     if (state is LoginGoogleStateSuccess) {
      //       overlay.hide();
      //       Navigator.pushAndRemoveUntil(
      //         context,
      //         MaterialPageRoute(builder: (context) => NavigationScreen()),
      //             (route) => false,
      //       );
      //     } else if (state is LoginGoogleStateError) {
      //       overlay.hide();
      //       context.showCustomToast(
      //         position: SnackBarPosition.top,
      //         title: "Error",
      //         message: state.message,
      //         isSuccess: false,
      //       );
      //     } else if (state is LoginGoogleStateLoading) {
      //       overlay.show(context);
      //     }
      //   },
      // ),
    ];
  }
}