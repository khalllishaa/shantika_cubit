import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shantika_cubit/utility/extensions/show_toast.dart';

import '../../ui/color.dart';
import '../../ui/dimension.dart';
import '../../ui/shared_widget/common_appbar.dart';
import '../../ui/shared_widget/custom_button.dart';
import '../../ui/shared_widget/custom_text_form_field.dart';
import '../../ui/shared_widget/sheet/select_media_source_sheet.dart';
import '../../ui/typography.dart';
import '../../utility/loading_overlay.dart';
import 'cubit/assignment_review_cubit.dart';
import 'cubit/detail_history_assignment_cubit.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key, required this.id});
  final String id;

  @override
  State<RatingScreen> createState() => RatingScreenState();
}

late AssignmentReviewCubit _assignmentReviewCubit;

File? _selectedAttachment;

LoadingOverlay _overlay = LoadingOverlay();

class RatingScreenState extends State<RatingScreen> {
  final String image = "assets/images/img_stars.png";
  final String title = "Apakah anda puas dengan layanan kami dari aplikasi?";
  final String content = "";
  final _reviewController = TextEditingController();

  int _rating = 0;
  @override
  void initState() {
    _selectedAttachment = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _assignmentReviewCubit = context.read();
    _assignmentReviewCubit.init();

    return Scaffold(
      appBar: CommonAppbar(
        leading: true,
        title: "Beri Penilaian",
      ),
      body: BlocListener<AssignmentReviewCubit, AssignmentReviewState>(
        listener: (context, state) {
          if (state is AssignmentReviewStateSuccess) {
            _overlay.hide();
            context.read<DetailHistoryAssignmentCubit>()..detailHistory(id: widget.id);
            context.showCustomToast(title: "Berhasil", message: "Terimakasih atas penilaian anda", isSuccess: true);
          } else if (state is AssignmentReviewStateError) {
            _overlay.hide();
            context.showCustomToast(title: "Oopss", message: state.message, isSuccess: false);
          } else {
            _overlay.show(context);
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: space400, vertical: space800),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRating(),
                SizedBox(height: space600),
                _buildLabel(context),
                SizedBox(height: space600),
                _buildReview(_reviewController),
                SizedBox(height: space600),
                _buildUploadRating(
                  image,
                  title,
                  content,
                  context,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRating() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Bagikan Penilaian", style: mdBold),
        SizedBox(height: space050),
        Text("Penilaian bagi anda sangat berpengaruh bagi mitra kami.", style: smRegular),
        SizedBox(height: space800),
        Text("Berapa penilaian kamu?", style: smMedium),
        SizedBox(height: space200),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(
            5,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  _rating = index + 1;
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: space150),
                child: SvgPicture.asset(
                  "${index < _rating ? "assets/images/ic_star.svg" : "assets/images/ic_star_border.svg"}",
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  void _showSheetUploadImage({required BuildContext context}) {
    showMaterialModalBottomSheet(
      context: context,
      builder: (context2) {
        return SelectMediaSourceSheet(onSelected: (source) async {
          final XFile? image = await ImagePicker().pickImage(
            source: source,
            maxHeight: 700,
            maxWidth: 700,
          );
          if (image != null) {
            final file = File(image.path);
            _selectedAttachment = file;
            setState(() {});
          }
        });
      },
    );
  }

  Widget _buildLabel(context) {
    return Column(
      children: [
        Row(
          children: [
            Text("Lampiran", style: smMedium),
            SizedBox(width: space100),
            Text(
              "(Opsional)",
              style: xsRegular.copyWith(color: textNeutralSecondary),
            )
          ],
        ),
        SizedBox(height: space150),
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(borderRadius200),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (_selectedAttachment == null) ...[
                Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(color: black200),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        _showSheetUploadImage(context: context);
                      },
                      child: SvgPicture.asset(
                        'assets/images/ic_upload.svg',
                        height: 16,
                        width: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: space300),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Drag and drop or", style: smMedium.copyWith(color: textNeutralSecondary)),
                    Text(" click to choose files",
                        style: smMedium.copyWith(color: textPrimary)), // fix typo "thoose" -> "choose"
                  ],
                ),
              ] else ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(8), // Biar ga terlalu tajem
                  child: Padding(
                    padding: const EdgeInsets.all(space400),
                    child: Image.file(
                      _selectedAttachment!,
                      fit: BoxFit.cover,
                      height: 100,
                      width: double.infinity,
                    ),
                  ),
                ),
              ],
              SizedBox(height: space100),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/ic_warning_notif.svg',
                    color: bgFillNeutral,
                    height: 10,
                    width: 10,
                  ),
                  SizedBox(width: space050),
                  Text("Max file size: 10MB", style: xsRegular.copyWith(color: textNeutralSecondary)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReview(TextEditingController _reviewController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Bagikan Ulasan", style: smMedium),
        CustomTextFormField(
          verticalContentPadding: space300,
          maxLines: 5,
          controller: _reviewController,
          placeholder: "Beri ulasan",
        ),
      ],
    );
  }

  Widget _buildUploadRating(String image, String title, String content, context) {
    return CustomButton(
      width: double.infinity,
      child: Text("Unggah Penilaian", style: smMedium),
      onPressed: () {
        _assignmentReviewCubit.review(
          id: widget.id,
          starCount: _rating.toString(),
          review: _reviewController.text,
          attachment: _selectedAttachment,
        );
      },
    );
  }
}
