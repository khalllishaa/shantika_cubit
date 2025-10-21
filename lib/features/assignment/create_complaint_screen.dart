import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shantika_cubit/utility/extensions/show_toast.dart';

import '../../ui/color.dart';
import '../../ui/dimension.dart';
import '../../ui/shared_widget/common_appbar.dart';
import '../../ui/shared_widget/custom_button.dart';
import '../../ui/shared_widget/custom_text_form_field.dart';
import '../../ui/typography.dart';
import '../../utility/loading_overlay.dart';
import 'cubit/complaint_cubit.dart';

class CreateComplaintScreen extends StatefulWidget {
  const CreateComplaintScreen({super.key, required this.id});
  final String id;

  @override
  State<CreateComplaintScreen> createState() => _CreateComplaintScreenState();
}

late ComplaintCubit _complaintCubit;

class _CreateComplaintScreenState extends State<CreateComplaintScreen> {
  final String image = "assets/images/img_not_approved.png";
  final String title = "Batalkan Penugasan?";
  final String message = "Apakah anda yakin ingin membatalkan penugasan ini?";
  int? initialSelectedIndex;

  final _key = GlobalKey<FormState>();

  List<String> dummyComplainList = [
    'Tidak sesuai durasi',
    'Terlambat 1 jam datang',
    'Tidak memenuhi aturan',
    'Cancel tiba-tiba',
    'Tidak ramah'
  ];

  final _complaintController = TextEditingController();

  LoadingOverlay _overlay = LoadingOverlay();

  @override
  Widget build(BuildContext context) {
    _complaintCubit = context.read();
    _complaintCubit.init();

    return Scaffold(
      appBar: CommonAppbar(leading: true, title: "Ajukan Komplain"),
      body: Form(
        key: _key,
        child: SingleChildScrollView(
          child: BlocListener<ComplaintCubit, ComplaintState>(
            listener: (context, state) {
              if (state is ComplaintStateSuccess) {
                _overlay.hide();
                context.showCustomToast(title: "Sukses", message: "Komplain berhasil terkirim", isSuccess: true);
              } else if (state is ComplaintStateError) {
                _overlay.hide();
                context.showCustomToast(title: "Oops", message: state.message, isSuccess: false);
              } else {
                _overlay.show(context);
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: space400, vertical: space800),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextFormField(
                    titleSection: 'Form Pengajuan Komplain',
                    controller: _complaintController,
                    verticalContentPadding: 10,
                    placeholder: 'Masukan keluhan anda disini',
                    maxLines: 5,
                    validator: (e) => e.isEmpty ? "Harus diisi" : null,
                  ),
                  SizedBox(height: space800),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: List.generate(dummyComplainList.length, (i) {
                      return feedbackChip(dummyComplainList[i], () {
                        setState(() {
                          _complaintController.text = dummyComplainList[i];
                          initialSelectedIndex = i;
                        });
                      }, i == initialSelectedIndex);
                    }),
                  ),
                  SizedBox(height: space800),
                  CustomButton(
                    child: Text(
                      "Ajukan Komplain",
                      style: smMedium,
                    ),
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        _complaintCubit.createComplaint(id: widget.id, complain: _complaintController.text);
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget feedbackChip(String text, void Function()? onTap, bool isSelected) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: space300, vertical: space200),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : bg,
          border: Border.all(color: bgFillPrimary),
          borderRadius: BorderRadius.circular(borderRadius500),
        ),
        child: Text(
          text,
          style: smMedium.copyWith(color: isSelected ? black50 : textPrimary),
        ),
      ),
    );
  }
}
