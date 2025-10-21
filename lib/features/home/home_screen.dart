import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shantika_cubit/features/home/slider_detail_screen.dart';
import 'package:shantika_cubit/utility/extensions/show_toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../config/constant.dart';
import '../../config/service_locator.dart';
import '../../config/user_preference.dart';
import '../../model/apps_model.dart';
import '../../model/article_model.dart';
import '../../model/guard_type_model.dart';
import '../../model/promo_model.dart';
import '../../model/response/home_response.dart';
import '../../model/slider_model.dart';
import '../../model/user_model.dart';
import '../../ui/color.dart';
import '../../ui/dimension.dart';
import '../../ui/shared_widget/circle_image_view.dart';
import '../../ui/shared_widget/custom_button.dart';
import '../../ui/shared_widget/custom_card.dart';
import '../../ui/shared_widget/custom_card_article.dart';
import '../../ui/shared_widget/custom_voucher.dart';
import '../../ui/shared_widget/empty_view.dart';
import '../../ui/shared_widget/error_view.dart';
import '../../ui/shared_widget/network_image_view.dart';
import '../../ui/typography.dart';
// import '../article/article_screen.dart';
// import '../guard_schedule/schedule_guard_event_screen.dart';
// import '../guard_schedule/schedule_guard_monthly_screen.dart';
// import '../guard_schedule/schedule_guard_personal_screen.dart';
// import '../notification/notification_screen.dart';
// import '../promo/promo_screen.dart';
import 'cubit/home_cubit.dart';
import 'home_shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ValueNotifier<int> initialIndexSlider = ValueNotifier(0);

  late HomeCubit _homeCubit;

  @override
  Widget build(BuildContext context) {
    _homeCubit = context.read();
    _homeCubit.init();
    _homeCubit.home();
    return _buildMainView();
  }

  Widget _buildMainView() {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: space400, vertical: space300),
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeStateSuccess) {
                  List<GuardTypeModel> guardTypes = state.data.guard_types ?? [];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildAppBarView(),
                      const SizedBox(height: space400),
                      Row(),
                    ],
                  );
                } else if (state is HomeStateError) {
                  return ErrorView(
                    title: "Ada Kendala",
                    desc: state.message,
                    onReload: () {
                      _homeCubit.home();
                    },
                  );
                } else {
                  return HomeShimmer();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildPromoView({required HomeResponse response}) {
  //   List<PromoModel> promos = response.promos ?? [];
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           const Text('Lebih Murah', style: xlSemiBold),
  //           GestureDetector(
  //             onTap: () {
  //               Navigator.push(
  //                 context,
  //                 MaterialPageRoute(builder: (context) => PromoScreen()),
  //               );
  //             },
  //             child: Text(
  //               'Lebih Banyak',
  //               style: smMedium.copyWith(color: bgFillDanger),
  //             ),
  //           ),
  //         ],
  //       ),
  //       const SizedBox(height: space300),
  //       promos.isNotEmpty
  //           ? ListView.separated(
  //               separatorBuilder: (context, index) => const SizedBox(height: space200),
  //               itemCount: promos.length,
  //               shrinkWrap: true,
  //               physics: const NeverScrollableScrollPhysics(),
  //               itemBuilder: (context, index) {
  //                 return CustomVoucher(data: promos[index]);
  //               },
  //             )
  //           : EmptyView()
  //     ],
  //   );
  // }
  //
  // Widget _buildArticleView({required HomeResponse response}) {
  //   List<ArticleModel> articles = response.articles ?? [];
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           const Text('Lihat Artikel', style: xlSemiBold),
  //           GestureDetector(
  //             onTap: () {
  //               Navigator.push(
  //                 context,
  //                 MaterialPageRoute(builder: (context) => ArticleScreen()),
  //               );
  //             },
  //             child: Text(
  //               'Lebih Banyak',
  //               style: smMedium.copyWith(color: bgFillDanger),
  //             ),
  //           ),
  //         ],
  //       ),
  //       const SizedBox(height: space300),
  //       ListView.separated(
  //         separatorBuilder: (context, index) => const SizedBox(height: space200),
  //         itemCount: articles.length,
  //         shrinkWrap: true,
  //         physics: const NeverScrollableScrollPhysics(),
  //         itemBuilder: (context, index) {
  //           return CustomCardArticle(
  //             slug: articles[index].slug ?? "",
  //             title: articles[index].title ?? "",
  //             content: articles[index].content ?? "",
  //             img: '${baseImage}/${articles[index].thumbnail}',
  //             date: articles[index].createdAt ?? "",
  //             desc: articles[index].slug ?? "",
  //           );
  //         },
  //       )
  //     ],
  //   );
  // }
  //
  // Widget _buildInformationView({required HomeResponse response}) {
  //   List<SliderModel> sliders = response.sliders ?? [];
  //   return ValueListenableBuilder(
  //     valueListenable: initialIndexSlider,
  //     builder: (context, value, child) => Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         const Text('Informasi Untuk Anda', style: xlSemiBold),
  //         const SizedBox(height: space100),
  //         Text(
  //           'Berbagai informasi pengamanan ada disini',
  //           style: smRegular.copyWith(
  //             color: textDarkSecondary,
  //           ),
  //         ),
  //         const SizedBox(height: space400),
  //         SizedBox(
  //           height: 200,
  //           width: double.infinity,
  //           child: PageView.builder(
  //             itemCount: sliders.length,
  //             scrollDirection: Axis.horizontal,
  //             itemBuilder: (context, index) {
  //               return _informationItemView(sliders[index]);
  //             },
  //             onPageChanged: (e) {
  //               initialIndexSlider.value = e;
  //             },
  //           ),
  //         ),
  //         const SizedBox(height: space400),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             _buildIndicatorView(context, sliders.length),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget _buildIndicatorView(BuildContext context, int length) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: space400),
  //     child: ValueListenableBuilder(
  //       valueListenable: initialIndexSlider,
  //       builder: (context, value, child) => AnimatedContainer(
  //         duration: const Duration(milliseconds: 800),
  //         height: 20,
  //         padding: const EdgeInsets.symmetric(horizontal: space200, vertical: space150),
  //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(999), color: borderNeutralLight),
  //         child: Row(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             for (int i = 0; i < length; i++) ...[
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: space100),
  //                 child: Container(
  //                   padding: const EdgeInsets.symmetric(horizontal: space100, vertical: space100),
  //                   width: i == value ? 20 : 8,
  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(i == value ? borderRadius500 : 999),
  //                     color: i == value ? bgFillPrimary : bgLight,
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget _informationItemView(SliderModel? slider) {
  //   return AspectRatio(
  //     aspectRatio: 16 / 9,
  //     child: GestureDetector(
  //       onTap: () {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(builder: (context) => SliderDetailScreen(slug: slider?.slug ?? "")),
  //         );
  //       },
  //       child: Container(
  //         height: 200,
  //         width: 328,
  //         decoration: BoxDecoration(
  //           color: Colors.transparent,
  //           borderRadius: BorderRadius.circular(12),
  //         ),
  //         child: ClipRRect(
  //           borderRadius: BorderRadius.circular(12),
  //           child: Stack(
  //             children: [
  //               NetworkImageView(
  //                 height: 200,
  //                 width: 300,
  //                 fit: BoxFit.cover,
  //                 url: '${baseImage}/${slider?.thumbnail ?? ""}',
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget _buildConsultView({required HomeResponse response}) {
  //   AppsModel apps = response.apps ?? AppsModel();
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       const Text('Konsultasi', style: xlSemiBold),
  //       const SizedBox(height: space100),
  //       Text(
  //         'Konsultasikan layanan yang ingin dipesan',
  //         style: smRegular.copyWith(
  //           color: textDarkSecondary,
  //         ),
  //       ),
  //       const SizedBox(height: space400),
  //       Container(
  //         height: 200,
  //         width: double.infinity,
  //         decoration: BoxDecoration(
  //           color: Colors.transparent,
  //           borderRadius: BorderRadius.circular(12),
  //           image: const DecorationImage(
  //             image: NetworkImage(
  //               'https://images.unsplash.com/photo-1588058365548-9efe5acb8077?q=80&w=3540&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  //             ),
  //             fit: BoxFit.cover,
  //           ),
  //         ),
  //         child: Column(
  //           children: [
  //             const Spacer(),
  //             Container(
  //               decoration: BoxDecoration(
  //                 color: Colors.black.withOpacity(0.58),
  //                 borderRadius: BorderRadius.circular(8),
  //               ),
  //               width: double.infinity,
  //               height: 50,
  //               child: Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: Row(
  //                   children: [
  //                     SvgPicture.asset('assets/images/ic_message.svg'),
  //                     const SizedBox(width: space200),
  //                     Text(
  //                       'Hubungi sekarang',
  //                       style: smMedium.copyWith(color: black50),
  //                     ),
  //                     const Spacer(),
  //                     CustomButton(
  //                       onPressed: () async {
  //                         if (await canLaunchUrl(Uri.parse("tel://${apps.phone}"))) {
  //                           await launchUrlString("tel://${apps.phone}");
  //                         } else {
  //                           context.showCustomToast(
  //                             title: "Opps",
  //                             message: "Gagal membuka telepon",
  //                             isSuccess: false,
  //                           );
  //                         }
  //                       },
  //                       child: const Padding(
  //                         padding: EdgeInsets.symmetric(
  //                           horizontal: space400,
  //                           vertical: space200,
  //                         ),
  //                         child: Text('Konsultasi', style: smMedium),
  //                       ),
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }
  //
  // Widget _serviceItemView({
  //   required String id,
  //   required String img,
  //   required String title,
  //   required SecurityType type,
  // }) {
  //   return Expanded(
  //     child: CustomCard(
  //       onTap: () {
  //         if (type == SecurityType.personal) {
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => ScheduleGuardPersonalScreen(guardTypeId: id),
  //             ),
  //           );
  //         } else if (type == SecurityType.event) {
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => ScheduleGuardEventScreen(guardTypeId: id),
  //             ),
  //           );
  //         } else {
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => ScheduleGuardMonthlyScreen(guardTypeId: id),
  //             ),
  //           );
  //         }
  //       },
  //       borderRadius: BorderRadius.circular(12),
  //       shadow: const [],
  //       color: transparentColor,
  //       borderSide: const BorderSide(
  //         color: borderNeutral,
  //       ),
  //       child: Padding(
  //         padding: const EdgeInsets.all(space400),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Image.asset(
  //               img,
  //               height: 60,
  //               width: 60,
  //               fit: BoxFit.contain,
  //             ),
  //             const SizedBox(height: space200),
  //             Text(title, style: xxsSemiBold)
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildAppBarView() {
    UserModel userPreference = serviceLocator.get<UserPreference>().getUser();

    return Row(
      children: [
        SizedBox(
          width: 42,
          height: 42,
          child: CircleImageView(
            url: userPreference.avatar != null
                ? '${baseImage}/${userPreference.avatar}'
                : 'https://avatar.iran.liara.run/public',
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: space400),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Selamat Datang!', style: xsMedium.copyWith(color: textDarkSecondary)),
            Text(userPreference.name ?? "", style: lgSemiBold),
          ],
        ),
        // const Spacer(),
        // IconButton(
        //   onPressed: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => NotificationScreen()),
        //     );
        //   },
        //   icon: SvgPicture.asset('assets/images/ic_notification.svg'),
        // ),
      ],
    );
  }
}
