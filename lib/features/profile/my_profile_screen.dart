import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shantika_cubit/utility/extensions/show_toast.dart';
import '../../config/constant.dart';
import '../../model/user_model.dart';
import '../../ui/color.dart';
import '../../ui/dimension.dart';
import '../../ui/shared_widget/circle_image_view.dart';
import '../../ui/shared_widget/common_appbar.dart';
import '../../ui/shared_widget/custom_button.dart';
import '../../ui/shared_widget/custom_date_picker.dart';
import '../../ui/shared_widget/custom_dropdown_button.dart';
import '../../ui/shared_widget/custom_text_form_field.dart';
import '../../ui/shared_widget/sheet/select_media_source_sheet.dart';
import '../../ui/typography.dart';
import '../../utility/loading_overlay.dart';
import 'cubit/profile_cubit.dart';
import 'cubit/update_profile_cubit.dart';

class MyProfileScreen extends StatefulWidget {
  MyProfileScreen({super.key, required this.user});

  final UserModel user;

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final ImagePicker picker = ImagePicker();
  OptionValue? selectedGender;
  XFile? pickedImage;
  late UpdateProfileCubit _updateProfileCubit;

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  DatePickerController _datePickerController = DatePickerController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  final _key = GlobalKey<FormState>();

  LoadingOverlay _overlay = LoadingOverlay();

  @override
  void initState() {
    String? numberWithoutPrefix = widget.user.phone?.replaceFirst(RegExp(r'^\+62'), '');
    _firstNameController.text = widget.user.firstName ?? "-";
    _lastNameController.text = widget.user.lastName ?? "-";
    _datePickerController.dateTime = DateTime.tryParse(
          widget.user.birthDate ?? DateTime.now().toString(),
        ) ??
        DateTime.now();
    _phoneController.text = numberWithoutPrefix ?? "";
    _emailController.text = widget.user.email ?? "";
    selectedGender = OptionValue(
      value: widget.user.gender ?? "",
      label: widget.user.gender == "MALE" ? "Laki-Laki" : "Perempuan",
    );

    _firstNameController.addListener(() {
      setState(() {});
    });

    _lastNameController.addListener(() {
      setState(() {});
    });

    _phoneController.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  _onGenderSelected(OptionValue gender) {
    setState(() {
      selectedGender = gender;
    });
  }

  @override
  Widget build(BuildContext context) {
    _updateProfileCubit = context.read();
    _updateProfileCubit.init();

    return Scaffold(
      appBar: const CommonAppbar(
        leading: true,
        title: "Profile Saya",
        centerTitle: true,
      ),
      backgroundColor: bgLight,
      body: SafeArea(
        child: Form(
          key: _key,
          child: BlocListener<UpdateProfileCubit, UpdateProfileState>(
            listener: (context, state) {
              if (state is UpdateProfileStateSuccess) {
                _overlay.hide();
                context.read<ProfileCubit>().profile();
                Navigator.pop(context);
              } else if (state is UpdateProfileStateError) {
                _overlay.hide();
                context.showCustomToast(title: "Oopss", message: state.message, isSuccess: false);
              } else {
                _overlay.show(context);
              }
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: space400, vertical: space800),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleImageView(
                            url: pickedImage == null && widget.user.avatar != null
                                ? '$baseUrl/${widget.user.avatar}'
                                : null,
                            imageFile: pickedImage != null ? File(pickedImage!.path) : null,
                            imageAsset: pickedImage == null && widget.user.avatar == null
                                ? "assets/images/img_profil_default.jpg"
                                : null,
                            imageType: pickedImage != null
                                ? ImageType.file
                                : widget.user.avatar != null
                                    ? ImageType.network
                                    : ImageType.asset,
                          ),
                          GestureDetector(
                            onTap: () {
                              showMediaSourceSheet(context);
                            },
                            child: CircleAvatar(
                              radius: 12,
                              backgroundColor: Colors.white,
                              child: SvgPicture.asset(
                                "assets/images/ic_camera.svg",
                                height: 12,
                                width: 12,
                                color: iconPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Basic Detail",
                          style: mSemiBold.copyWith(color: textDarkPrimary),
                        ),
                        SizedBox(height: space300),
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
                        CustomDatePicker(
                          titleSection: "Tanggal Lahir",
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2050),
                          defaultValue: _datePickerController.dateTime,
                          datePickerController: _datePickerController,
                          validator: (e) => e == null ? "Tanggal lahir harus diisi" : null,
                          onChanged: (e) => setState(() => null),
                        ),
                        _buildCustomWidget(
                          title: "Gender",
                          widget: Row(
                            children: [
                              Expanded(
                                child: _buildCustomCheckBox(
                                  gender: OptionValue(value: "MALE", label: "Laki-Laki"),
                                ),
                              ),
                              SizedBox(width: space300),
                              Expanded(
                                child: _buildCustomCheckBox(
                                  gender: OptionValue(value: "FEMALE", label: "Perempuan"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: space800),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Contact Detail",
                          style: mSemiBold.copyWith(color: textDarkPrimary),
                        ),
                        SizedBox(height: space300),
                        // CustomTextFormField(
                        //   titleSection: "Nomor Telfon",
                        //   controller: _phoneController,
                        //   prefixText: "+62",
                        //   placeholder: ' 8123456789',
                        //   keyboardType: TextInputType.number,
                        //   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        //   validator: (e) => e.isEmpty ? "Nomor Telefon harus diisi" : null,
                        // ),
                        CustomTextFormField(
                          prefixText: '+62 ',
                          titleSection: "Nomor Telepon",
                          controller: _phoneController,
                          validator: (e) {
                            if (e == "" || e.isEmpty) {
                              return "Nomor telepon tidak boleh kosong";
                            }
                            if (e[0] == '0') {
                              return "Nomor telepon tidak boleh diawali dengan '0'";
                            }
                            return null;
                          },
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          keyboardType: TextInputType.phone,
                        ),
                        _buildCustomWidget(
                          title: "Email",
                          widget: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: space300, vertical: space400),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(borderRadius300),
                              color: bgLight,
                              border: Border.all(color: borderNeutralDark),
                            ),
                            child: Text(
                              widget.user.email ?? "-",
                              style: smRegular.copyWith(color: textDarkPrimary),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: space800),
                    _buildButtonView(),
                    SizedBox(height: space400),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonView() {
    return SizedBox(
      height: 50,
      child: CustomButton(
        child: Padding(
          padding: const EdgeInsets.all(space300),
          child: Text(
            "Simpan",
            style: mdMedium.copyWith(color: textLightPrimary),
          ),
        ),
        onPressed: _key.currentState?.validate() == true &&
                _datePickerController.dateTime != null &&
                selectedGender != null
            ? () {
                if (_key.currentState!.validate() && _datePickerController.dateTime != null && selectedGender != null) {
                  _updateProfileCubit.updateProfile(
                    firstName: _firstNameController.text,
                    lastName: _lastNameController.text,
                    birthDate: _datePickerController.dateTime,
                    avatar: pickedImage != null ? File(pickedImage?.path ?? "") : null,
                    phone: _phoneController.text,
                    gender: selectedGender!.value,
                    email: _emailController.text,
                  );
                } else {}
              }
            : null,
      ),
    );
  }

  Future<dynamic> showMediaSourceSheet(BuildContext context) {
    return showMaterialModalBottomSheet(
      context: context,
      builder: (context) {
        return SelectMediaSourceSheet(
          onSelected: (e) async {
            pickedImage = await picker.pickImage(source: e);

            if (pickedImage != null) {
              setState(() {
                pickedImage = pickedImage;
              });
            }
          },
        );
      },
    );
  }

  Widget _buildCustomWidget({required String title, required Widget widget}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: smMedium.copyWith(color: textDarkPrimary),
        ),
        SizedBox(height: 6),
        widget
      ],
    );
  }

  Widget _buildCustomCheckBox({required OptionValue gender}) {
    bool isSelected = selectedGender == gender;
    return InkWell(
      onTap: () => _onGenderSelected(gender),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: space400, vertical: space300),
        decoration: BoxDecoration(
          border: Border.all(color: borderNeutralLight),
          borderRadius: BorderRadius.circular(borderRadius200),
          color: bgLight,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: space100, vertical: space100),
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: borderNeutralLight)),
              child: Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? bgFillPrimary : bgLight,
                ),
              ),
            ),
            SizedBox(width: space300),
            Text(
              gender.label,
              style: smRegular.copyWith(color: textDarkPrimary),
            ),
          ],
        ),
      ),
    );
  }
}
