import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shantika_cubit/features/assignment/rating_screen.dart';
import 'package:shantika_cubit/utility/extensions/date_time_extensions.dart';
import 'package:shantika_cubit/utility/extensions/int_extension.dart';

import '../../config/constant.dart';
import '../../model/detail_assignment_history_model.dart';
import '../../model/transaction_model.dart';
import '../../ui/color.dart';
import '../../ui/dimension.dart';
import '../../ui/shared_widget/common_appbar.dart';
import '../../ui/shared_widget/custom_button.dart';
import '../../ui/shared_widget/custom_text_form_field.dart';
import '../../ui/shared_widget/error_view.dart';
import '../../ui/typography.dart';
import 'contract_screen.dart';
import 'create_complaint_screen.dart';
import 'cubit/detail_history_assignment_cubit.dart';
class AssignmentDetailScreen extends StatefulWidget {
  AssignmentDetailScreen({super.key, required this.id});
  final String id;

  @override
  State<AssignmentDetailScreen> createState() => _AssignmentDetailScreenState();
}

late DetailHistoryAssignmentCubit _detailHistoryAssignmentCubit;

class _AssignmentDetailScreenState extends State<AssignmentDetailScreen> {
  final _notesController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _detailHistoryAssignmentCubit = context.read();
    _detailHistoryAssignmentCubit.init();
    _detailHistoryAssignmentCubit.detailHistory(id: widget.id);

    return Scaffold(
      appBar: CommonAppbar(leading: true, title: "Detail Penugasan"),
      body: RefreshIndicator(
        onRefresh: () async {
          _detailHistoryAssignmentCubit.detailHistory(id: widget.id);
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: space400, vertical: 26),
            child: BlocBuilder<DetailHistoryAssignmentCubit, DetailHistoryAssignmentState>(
              builder: (context, state) {
                if (state is DetailHistoryAssignmentStateSuccess) {
                  DetailAssignmentHistoryModel? data = state.data;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildWorkAddress(data),
                      SizedBox(height: space600),
                      _buildPersonalSecurity(_notesController, data),
                      SizedBox(height: space600),
                      //_buildSecurityContact(context, data),
                      SizedBox(height: space600),
                      _buildComplaint(context, data),
                      SizedBox(height: space600),
                      _buildRating(context, data, data),
                      SizedBox(height: space800),
                      _buildTotalPrice(context, data),
                    ],
                  );
                } else if (state is DetailHistoryAssignmentStateError) {
                  return ErrorView(
                    title: "Oops",
                    desc: state.message,
                    onReload: () {
                      _detailHistoryAssignmentCubit.detailHistory(id: widget.id);
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildWorkAddress(DetailAssignmentHistoryModel? data) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Alamat Pengerjaan", style: mdSemiBold),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: space250, vertical: space200),
            decoration: BoxDecoration(
              color: getStatusContainerColor(data?.status ?? AssignmentHistoryStatus.pending),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(
              data?.status?.translatedName ?? "-",
              style: xsMedium.copyWith(color: getStatusTextColor(data?.status ?? AssignmentHistoryStatus.pending)),
            ),
          ),
        ],
      ),
      SizedBox(height: space200),
      Text(
        data?.userAddress?.address ?? "-",
        style: xsRegular.copyWith(color: textNeutralSecondary),
      ),
    ],
  );
}

Widget _buildPersonalSecurity(TextEditingController _notesController, DetailAssignmentHistoryModel? data) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(data?.guardType?.name ?? "-", style: mdSemiBold),
      SizedBox(height: space200),
      Text("Durasi", style: xsRegular.copyWith(color: textNeutralSecondary)),
      SizedBox(height: space050),
      Text(
          "${data?.startTime?.convert(format: "EE, dd MMM yyyy, HH:mm")} - ${data?.endTime?.convert(format: "EE, dd MMM yyyy, HH:mm")}",
          style: smMedium),
      SizedBox(height: space200),
      Text("Jadwal Mulai", style: xsRegular.copyWith(color: textNeutralSecondary)),
      SizedBox(height: space050),
      Text("${data?.startTime?.convert(format: "EE, dd MMM yyyy, HH:mm")}", style: smMedium),
      SizedBox(height: space200),
      Text("Masukkan Catatan", style: xsRegular.copyWith(color: textNeutralSecondary)),
      SizedBox(height: space050),
      CustomTextFormField(
        verticalContentPadding: space200,
        maxLines: 5,
        controller: _notesController,
        placeholder: "Masukkan catatan tambahan",
      )
    ],
  );
}

// Widget _buildSecurityContact(BuildContext context, DetailAssignmentHistoryModel? data) {
//   return Visibility(
//     visible: data?.guardHistoryOfficers?.isNotEmpty ?? false,
//     child: Row(
//       children: [
//         Expanded(
//           child: Row(
//             children: [
//               CircleImageView(
//                 fit: BoxFit.cover,
//                 radius: 16,
//                 url: '${baseImage}/${data?.guardHistoryOfficers?.first.guardRelation?.avatar}',
//               ),
//               SizedBox(width: space300),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Text("${data?.guardHistoryOfficers?.first.guardRelation?.avatar}",
//                           style: smMedium, overflow: TextOverflow.ellipsis),
//                       SizedBox(width: space300),
//                       Container(
//                         padding: const EdgeInsets.symmetric(horizontal: space200, vertical: space100),
//                         decoration: BoxDecoration(
//                           color: bgSurfacePrimary,
//                           borderRadius: BorderRadius.circular(100),
//                         ),
//                         child: Text(
//                           "Gold",
//                           style: xsMedium.copyWith(color: textPrimary),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: space050),
//                   Text(
//                     "Laki - Laki",
//                     style: xsRegular.copyWith(color: textNeutralSecondary),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         Container(
//           height: 36,
//           width: 36,
//           decoration: BoxDecoration(
//               shape: BoxShape.rectangle,
//               border: Border.all(color: black200),
//               borderRadius: const BorderRadius.all(Radius.circular(8))),
//           child: Center(
//             child: InkWell(
//               onTap: () {
//                 // Navigator.pop(context);
//               },
//               child: SvgPicture.asset(
//                 'assets/images/ic_love.svg',
//                 height: 16,
//                 width: 16,
//               ),
//             ),
//           ),
//         ),
//         SizedBox(width: space200),
//         Container(
//           height: 36,
//           width: 36,
//           decoration: BoxDecoration(
//               color: bgFillSecondary,
//               shape: BoxShape.rectangle,
//               border: Border.all(color: black200),
//               borderRadius: const BorderRadius.all(Radius.circular(8))),
//           child: Center(
//             child: InkWell(
//               onTap: () {
//                 // Navigator.push(context,
//                 //     MaterialPageRoute(builder: (context) => RatingScreen()));
//               },
//               child: SvgPicture.asset(
//                 'assets/images/ic_call.svg',
//                 height: 16,
//                 width: 16,
//               ),
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }

Widget _buildComplaint(BuildContext context, DetailAssignmentHistoryModel? data) {
  return Row(
    children: [
      Expanded(
        child: Row(
          children: [
            Image.asset("assets/images/img_danger.png"),
            SizedBox(width: space300),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Ajukan Komplain", style: mdSemiBold),
                SizedBox(height: space050),
                Text("Ajukan komplain untuk Mitra", style: smRegular.copyWith(color: textNeutralSecondary)),
              ],
            ),
          ],
        ),
      ),
      Container(
        height: 36,
        width: 36,
        decoration: BoxDecoration(
          color: bgFillPrimary,
          shape: BoxShape.rectangle,
          border: Border.all(color: black200),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: Center(
          child: InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateComplaintScreen(
                  id: data?.id ?? "",
                ),
              ),
            ),
            child: SvgPicture.asset(
              'assets/images/ic_caret_circle_right.svg',
              height: 16,
              width: 16,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _buildRating(BuildContext context, status, DetailAssignmentHistoryModel? data) {
  return Visibility(
    visible: true,
    child: Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Text(data?.review?.star.toString() ?? "", style: xlBold),
              SizedBox(width: space300),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Beri Penilaian", style: mdSemiBold),
                  SizedBox(height: space050),
                  Row(
                    children: List.generate(
                      (data?.review?.star ?? 0) > 0 ? (data?.review?.star ?? 0).clamp(0, 5) : 5,
                      (index) => Padding(
                        padding: const EdgeInsets.only(right: space200),
                        child: SvgPicture.asset(
                          (data?.review?.star ?? 0) > 0
                              ? "assets/images/ic_star.svg"
                              : "assets/images/ic_star_border.svg",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          height: 36,
          width: 36,
          decoration: BoxDecoration(
              color: bgFillPrimary,
              shape: BoxShape.rectangle,
              border: Border.all(color: black200),
              borderRadius: const BorderRadius.all(Radius.circular(8))),
          child: Center(
            child: InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RatingScreen(
                            id: data?.id ?? "",
                          ))),
              child: SvgPicture.asset(
                'assets/images/ic_caret_circle_right.svg',
                height: 16,
                width: 16,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildTotalPrice(BuildContext context, DetailAssignmentHistoryModel? data) {
  TransactionModel? trx = data?.transaction;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Total:", style: mdMedium.copyWith(color: textNeutralSecondary)),
      SizedBox(height: space100),
      Text((trx?.payAmount ?? 0).convertRupiah(), style: xlSemiBold),
      SizedBox(height: space400),
      CustomButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/images/ic_book.svg"),
            SizedBox(width: space200),
            Text("Baca Kontrak", style: smMedium)
          ],
        ),
        onPressed: () async {
          final path = "assets/pdfview.pdf";
          final file = await PdfApi.loadAsset(path);

          openPDF(context, file);
        },
      ),
      SizedBox(height: space200),
      GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          height: 36,
          decoration: BoxDecoration(
            // color: bgFillSecondary,
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(borderRadius200),
          ),
          child: Center(
            child: Text(
              "Batalkan Penugasan",
              style: smMedium,
            ),
          ),
        ),
      )
    ],
  );
}

class PdfApi {
  static Future<File> loadAsset(String path) async {
    final data = await rootBundle.load(path);
    final bytes = data.buffer.asUint8List();

    return _storeFile(path, bytes);
  }

  static Future<File> _storeFile(String url, List<int> bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }
}

void openPDF(BuildContext context, File file) => Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => ContractScreen(file: file)),
    );

Color getStatusContainerColor(AssignmentHistoryStatus status) {
  if (status == AssignmentHistoryStatus.upcoming) {
    return bgSurfaceSecondary;
  } else if (status == AssignmentHistoryStatus.process) {
    return bgSurfacePrimary;
  } else if (status == AssignmentHistoryStatus.finished) {
    return bgSurfaceSuccess;
  } else if (status == AssignmentHistoryStatus.cancelled) {
    return bgSurfaceNeutralLight;
  } else if (status == AssignmentHistoryStatus.pending) {
    return bgSurfaceNeutralLight;
  } else {
    return bgSurfaceNeutralLight;
  }
}

Color getStatusTextColor(AssignmentHistoryStatus status) {
  if (status == AssignmentHistoryStatus.upcoming) {
    return textSecondary;
  } else if (status == AssignmentHistoryStatus.process) {
    return textPrimary;
  } else if (status == AssignmentHistoryStatus.finished) {
    return textSuccess;
  } else if (status == AssignmentHistoryStatus.cancelled) {
    return textDarkSecondary;
  } else if (status == AssignmentHistoryStatus.pending) {
    return textDarkSecondary;
  } else {
    return textDarkSecondary;
  }
}
