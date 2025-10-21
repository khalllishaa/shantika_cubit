import 'package:flutter/material.dart';
import 'package:shantika_cubit/model/promo_model.dart';
import 'package:with_space_between/with_space_between.dart';

import '../../config/constant.dart';
import '../color.dart';
import '../dimension.dart';
import '../typography.dart';
import 'custom_button.dart';
import 'network_image_view.dart';

class CustomVoucher extends StatelessWidget {
  CustomVoucher({super.key, this.data, this.onUsed});

  final PromoModel? data;
  final void Function()? onUsed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 200,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius200),
            child: NetworkImageView(
              url: '${baseImage}/${data?.thumbnail}',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          left: 240,
          top: 145,
          child: SizedBox(
            width: 100,
            height: 40,
            child: CustomButton(
              onPressed: onUsed,
              child: Text(
                "Gunakan",
                style: smMedium.copyWith(color: textLightPrimary),
              ),
            ),
          ),
        ),
        Positioned(
            top: 45,
            left: 0,
            child: ClipPath(
              clipper: TicketClipper(),
              child: Container(
                padding: const EdgeInsets.only(left: space100, bottom: space300, right: space100, top: space800),
                decoration: BoxDecoration(color: bgFillPrimary, borderRadius: BorderRadius.circular(borderRadius200)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data?.name ?? "-",
                          style: smSemiBold.copyWith(color: textLightPrimary),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Diskon",
                              style: xxsRegular.copyWith(color: textLightPrimary),
                            ),
                            Text(
                              "10%",
                              style: mSemiBold.copyWith(color: textLightPrimary),
                            ),
                          ],
                        )
                      ].withSpaceBetween(width: space400),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Berlaku Hingga",
                          style: xxsRegular.copyWith(color: textLightPrimary),
                        ),
                        Text(
                          "14 September 2025",
                          style: xxsSemiBold.copyWith(color: textLightPrimary),
                        ),
                      ],
                    ),
                    // CustomDashDivider(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "S&K",
                          style: xxsRegular.copyWith(color: textLightPrimary),
                        ),
                        Container(
                          width: 84,
                          padding: const EdgeInsets.symmetric(horizontal: space100, vertical: space100),
                          decoration: BoxDecoration(
                            color: primaryColor700,
                            borderRadius: BorderRadius.circular(borderRadius200),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Kode: ",
                                style: xxsRegular.copyWith(color: textLightPrimary),
                              ),
                              Flexible(
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  data?.code ?? "-",
                                  style: xxsSemiBold.copyWith(color: textLightPrimary),
                                ),
                              ),
                            ],
                          ),
                        )
                      ].withSpaceBetween(width: space400),
                    ),
                  ].withSpaceBetween(height: space400),
                ),
              ),
            ))
      ],
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  final int numberOfHoles;
  final double holeRadius;

  TicketClipper({this.numberOfHoles = 4, this.holeRadius = 10});

  @override
  Path getClip(Size size) {
    Path path = Path();

    path.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(8),
      ),
    );

    double spacing = size.width / (numberOfHoles + 1);

    for (int i = 0; i < numberOfHoles; i++) {
      double x = spacing * (i + 1);
      path.addOval(Rect.fromCircle(center: Offset(x, 0), radius: holeRadius));
    }

    path.fillType = PathFillType.evenOdd;
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
