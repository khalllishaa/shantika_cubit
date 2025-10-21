import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shantika_cubit/features/assignment/rating_screen.dart';
import 'package:shantika_cubit/utility/extensions/int_extension.dart';
import 'package:shantika_cubit/utility/extensions/widget_extensions.dart';

import '../../ui/color.dart';
import '../../ui/dimension.dart';
import '../../ui/shared_widget/custom_button.dart';
import '../../ui/shared_widget/custom_text_form_field.dart';
import '../../ui/typography.dart';
class AssignmentDetailShimmer extends StatefulWidget {
  const AssignmentDetailShimmer({super.key});

  @override
  State<AssignmentDetailShimmer> createState() => _AssignmentDetailShimmerState();
}

class _AssignmentDetailShimmerState extends State<AssignmentDetailShimmer> {
  final _notesController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: space400, vertical: 26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWorkAddress("Selesai"),
            SizedBox(height: space600),
            _buildPersonalSecurity(_notesController),
            SizedBox(height: space600),
            _buildSecurityContact(context),
            SizedBox(height: space600),
            _buildComplaint(context),
            SizedBox(height: space600),
            _buildRating(context, "Selesai"),
            SizedBox(height: space800),
            _buildTotalPrice(context),
          ],
        ),
      ),
    );
  }
}

Widget _buildWorkAddress(String status) {
  Color getStatusContainerColor(String status) {
    return status == "Akan Datang"
        ? bgSurfaceSecondary
        : status == "Berlangsung"
            ? bgSurfacePrimary
            : status == "Terselesaikan"
                ? bgSurfaceSuccess
                : status == "Dibatalkan"
                    ? bgSurfaceNeutralLight
                    : transparentColor; // Default jika status tidak cocok
  }

  Color getStatusTextColor(String status) {
    return status == "Akan Datang"
        ? textSecondary
        : status == "Berlangsung"
            ? textPrimary
            : status == "Terselesaikan"
                ? textSuccess
                : status == "Dibatalkan"
                    ? textDarkSecondary
                    : transparentColor; // Default jika status tidak cocok
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Alamat Pengerjaan", style: mdSemiBold).addShimmer(block: true),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: space250, vertical: space200),
            decoration: BoxDecoration(
              color: getStatusContainerColor(status),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(
              status,
              style: xsMedium.copyWith(color: getStatusTextColor(status)),
            ),
          ).addShimmer(block: true),
        ],
      ),
      SizedBox(height: space200),
      Text("Semarang, Jawa Tengah", style: smSemiBold).addShimmer(block: true),
      SizedBox(height: space200),
      Text(
        "Rumah",
        style: smMedium.copyWith(color: textNeutralSecondary),
      ).addShimmer(block: true),
      SizedBox(height: space050),
      Text(
        "Perumahan Baratayuda, No. 24",
        style: xsRegular.copyWith(color: textNeutralSecondary),
      ).addShimmer(block: true),
    ],
  );
}

Widget _buildPersonalSecurity(TextEditingController _notesController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Pengamanan Pribadi", style: mdSemiBold).addShimmer(block: true),
      SizedBox(height: space200),
      Text("Durasi", style: xsRegular.copyWith(color: textNeutralSecondary)).addShimmer(block: true),
      SizedBox(height: space050),
      Text("Rab, 23 Feb 2025, 08.00 - Sab, 31 Feb 2025, 18.00", style: smMedium).addShimmer(block: true),
      SizedBox(height: space200),
      Text("Jadwal Mulai", style: xsRegular.copyWith(color: textNeutralSecondary)).addShimmer(block: true),
      SizedBox(height: space050),
      Text("25 Jan 2025, 12.30 WIB", style: smMedium).addShimmer(block: true),
      SizedBox(height: space200),
      Text("Masukkan Catatan", style: xsRegular.copyWith(color: textNeutralSecondary)).addShimmer(block: true),
      SizedBox(height: space050),
      CustomTextFormField(
        verticalContentPadding: space200,
        maxLines: 5,
        controller: _notesController,
        placeholder: "Masukkan catatan tambahan",
      ).addShimmer(block: true)
    ],
  );
}

Widget _buildSecurityContact(BuildContext context) {
  return Row(
    children: [
      Expanded(
        child: Row(
          children: [
            CircleAvatar(
              child: Text(
                "SC",
                style: mBold,
              ),
            ),
            SizedBox(width: space300),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("Mafrud Amin", style: smMedium, overflow: TextOverflow.ellipsis),
                    SizedBox(width: space300),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: space200, vertical: space100),
                      decoration: BoxDecoration(
                        color: bgSurfacePrimary,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(
                        "Gold",
                        style: xsMedium.copyWith(color: textPrimary),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: space050),
                Text("Laki - Laki",
                    style: xsRegular.copyWith(color: textNeutralSecondary), overflow: TextOverflow.ellipsis),
              ],
            ),
          ],
        ),
      ).addShimmer(block: true),
      SizedBox(width: space200),
    ],
  );
}

Widget _buildComplaint(BuildContext context) {
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
      ).addShimmer(block: true),
    ],
  );
}

Widget _buildRating(BuildContext context, status) {
  return Visibility(
    visible: status == "Terselesaikan" ? true : false,
    child: Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Text("0.0", style: xlBold),
              SizedBox(width: space300),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Beri Penilaian", style: mdSemiBold),
                  SizedBox(height: space050),
                  Row(
                    children: List.generate(
                      5,
                      (index) => Padding(
                        padding: const EdgeInsets.only(right: space200),
                        child: SvgPicture.asset(
                          "assets/images/ic_star_border.svg",
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ).addShimmer(block: true),
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
                            id: "",
                          ))),
              child: SvgPicture.asset(
                'assets/images/ic_caret_circle_right.svg',
                height: 16,
                width: 16,
              ),
            ),
          ),
        ).addShimmer(block: true),
      ],
    ),
  );
}

Widget _buildTotalPrice(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Total:", style: mdMedium.copyWith(color: textNeutralSecondary)).addShimmer(block: true),
      SizedBox(height: space100),
      Text(200000.convertRupiah(), style: xlSemiBold).addShimmer(block: true),
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
        onPressed: () async {},
      ).addShimmer(block: true),
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
        ).addShimmer(block: true),
      )
    ],
  );
}
