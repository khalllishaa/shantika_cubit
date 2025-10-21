import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shantika_cubit/utility/extensions/widget_extensions.dart';
import 'package:with_space_between/with_space_between.dart';

import '../../ui/color.dart';
import '../../ui/dimension.dart';
import '../../ui/shared_widget/circle_image_view.dart';
import '../../ui/shared_widget/custom_card.dart';
import '../../ui/typography.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: space300),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 42,
                  height: 42,
                  child: CircleImageView(
                    url: 'https://avatar.iran.liara.run/public',
                    fit: BoxFit.cover,
                  ),
                ).addShimmer(),
                const SizedBox(width: space400),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Selamat Datang!', style: xsMedium.copyWith(color: textDarkSecondary)).addShimmer(block: true),
                    const Text('Dino', style: lgSemiBold).addShimmer(block: true),
                  ].withSpaceBetween(height: space100),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset('assets/images/ic_notification.svg').addShimmer(block: true),
                ),
              ],
            ),
            Row(
              spacing: space300,
              children: [
                Expanded(
                  child: CustomCard(
                    borderRadius: BorderRadius.circular(12),
                    shadow: const [],
                    color: transparentColor,
                    borderSide: const BorderSide(
                      color: borderNeutral,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(space400),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/img_personal_guard.png',
                            height: 60,
                            width: 60,
                            fit: BoxFit.contain,
                          ).addShimmer(),
                          const SizedBox(height: space200),
                          Text('Pengamanan\nPribadi', style: xxsSemiBold).addShimmer(block: true)
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: CustomCard(
                    borderRadius: BorderRadius.circular(12),
                    shadow: const [],
                    color: transparentColor,
                    borderSide: const BorderSide(
                      color: borderNeutral,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(space400),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/img_personal_guard.png',
                            height: 60,
                            width: 60,
                            fit: BoxFit.contain,
                          ).addShimmer(),
                          const SizedBox(height: space200),
                          Text('Pengamanan\nPribadi', style: xxsSemiBold).addShimmer(block: true)
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: CustomCard(
                    borderRadius: BorderRadius.circular(12),
                    shadow: const [],
                    color: transparentColor,
                    borderSide: const BorderSide(
                      color: borderNeutral,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(space400),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/img_personal_guard.png',
                            height: 60,
                            width: 60,
                            fit: BoxFit.contain,
                          ).addShimmer(),
                          const SizedBox(height: space200),
                          Text('Pengamanan\nPribadi', style: xxsSemiBold).addShimmer(block: true)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Konsultasi', style: xlSemiBold).addShimmer(block: true),
                const SizedBox(height: space100),
                Text(
                  'Konsultasikan layanan yang ingin dipesan',
                  style: smRegular.copyWith(
                    color: textDarkSecondary,
                  ),
                ).addShimmer(block: true),
                const SizedBox(height: space400),
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
                ).addShimmer(block: true)
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Informasi Untuk Anda', style: xlSemiBold).addShimmer(block: true),
                const SizedBox(height: space100),
                Text(
                  'Berbagai informasi pengamanan ada disini',
                  style: smRegular.copyWith(
                    color: textDarkSecondary,
                  ),
                ).addShimmer(block: true),
                const SizedBox(height: space400),
                Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
                ).addShimmer(block: true),
                const SizedBox(height: space400),
                Visibility(
                  visible: false,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: space400),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 800),
                          height: 20,
                          padding: const EdgeInsets.symmetric(horizontal: space200, vertical: space150),
                          decoration:
                              BoxDecoration(borderRadius: BorderRadius.circular(999), color: borderNeutralLight),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: space100),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: space100, vertical: space100),
                                  width: 8,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(999),
                                    color: bgFillPrimary,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: space100),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: space100, vertical: space100),
                                  width: 8,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(999),
                                    color: bgFillPrimary,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: space100),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: space100, vertical: space100),
                                  width: 20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(999),
                                    color: bgFillPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ).addShimmer()
                    ],
                  ),
                ),
              ],
            ),
            Visibility(
              visible: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Lihat Artikel', style: xlSemiBold).addShimmer(block: true),
                      Text(
                        'Lebih Banyak',
                        style: smMedium.copyWith(color: bgFillDanger),
                      ).addShimmer(block: true),
                    ],
                  ),
                  const SizedBox(height: space300),
                  ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(height: space200),
                    itemCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: space300, vertical: space300),
                        decoration: BoxDecoration(
                            color: bg,
                            border: Border.all(color: borderNeutral),
                            borderRadius: BorderRadius.circular(borderRadius500)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 32,
                                            width: 32,
                                            child: CircleImageView(url: 'https://avatar.iran.liara.run/public')
                                                .addShimmer(),
                                          ),
                                          Text(
                                            'Security Guards',
                                            style: smMedium.copyWith(color: textDarkPrimary),
                                          ).addShimmer(block: true),
                                        ].withSpaceBetween(width: space300),
                                      ),
                                      Text(
                                        "6 Visual Design Fundamental",
                                        style: mdBold.copyWith(color: textDarkPrimary),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                      ).addShimmer(block: true),
                                    ].withSpaceBetween(height: space200),
                                  ),
                                ),
                                Container(
                                  height: 100,
                                  width: 108,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
                                ).addShimmer(block: true)
                              ].withSpaceBetween(width: space200),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '14 September 2021',
                                  style: xsMedium.copyWith(color: textDarkSecondary),
                                ).addShimmer(block: true),
                                SvgPicture.asset(
                                  "assets/images/ic_more.svg",
                                  height: 20,
                                  width: 20,
                                ).addShimmer(block: true)
                              ],
                            ),
                            Text(
                              '6 Visual Design Fundamental',
                              style: smRegular.copyWith(color: textDarkPrimary),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ).addShimmer(block: true),
                          ].withSpaceBetween(height: space300),
                        ),
                      );
                    },
                  )
                ],
              ),
            )
          ].withSpaceBetween(height: space400),
        ),
      ),
    );
  }
}
