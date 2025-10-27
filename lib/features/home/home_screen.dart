import 'package:carousel_slider/carousel_slider.dart';
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
import '../../ui/shared_widget/custom_card_container.dart';
import '../../ui/shared_widget/custom_title.dart';
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
    return _buildMainView(context);
  }

  Widget _buildMainView(BuildContext context) {
    return Scaffold(
      backgroundColor: black00,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(Duration(seconds: 1));
            // controller.fetchHomeData(); // kalo nanti udah pakai controller
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                _headerWithSearch(),
                SizedBox(height: space600),
                imageSlider(),
                SizedBox(height: space600),
                menuFavorit(),
                SizedBox(height: space600),
                _promoCard(),
                SizedBox(height: space600),
                _riwayats(),
                _promoSection(),
                _artikelSection(),
                _buildTestimoniView(context),
                SizedBox(height: space600),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildMainView() {
  //   return Scaffold(
  //     body: SafeArea(
  //       child: SingleChildScrollView(
  //         child: Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: space400, vertical: space300),
  //           child: BlocBuilder<HomeCubit, HomeState>(
  //             builder: (context, state) {
  //               if (state is HomeStateSuccess) {
  //                 List<GuardTypeModel> guardTypes = state.data.guard_types ?? [];
  //                 return Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     _buildAppBarView(),
  //                     const SizedBox(height: space400),
  //                     Row(),
  //                   ],
  //                 );
  //               } else if (state is HomeStateError) {
  //                 return ErrorView(
  //                   title: "Ada Kendala",
  //                   desc: state.message,
  //                   onReload: () {
  //                     _homeCubit.home();
  //                   },
  //                 );
  //               } else {
  //                 return HomeShimmer();
  //               }
  //             },
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

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

  Widget _headerWithSearch() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: padding20),
                  child: Image.asset(
                    "images/logo_shantika.png",
                    height: 75,
                  ),
                ),
              ),
              Positioned(
                top: 55,
                right: 16,
                child: GestureDetector(
                  onTap: () {
                    // Get.to(() => NoticationsPage());
                  },
                  child: Icon(
                    Icons.notifications,
                    color: black00,
                    size: 28,
                  ),
                ),
              ),
            ],
          ),
        ),

        Positioned(
          bottom: -165,
          left: 16,
          right: 16,
          child: searchTicket(),
        ),
      ],
    );
  }

  Widget searchTicket() {
    // dummy data
    String departure = "";
    String arrival = "";

    return CustomCardContainer(
      borderRadius: borderRadius100,
      padding: EdgeInsets.all(paddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Center(
            child: Text(
              "Cari Tiket Bus",
              style: smMedium,
            ),
          ),
          SizedBox(height: space150),
          Stack(
            children: [
              Column(
                children: [
                  locationPicker("Keberangkatan", departure),
                  Container(
                    height: 1,
                    color: black700_70,
                    margin: EdgeInsets.symmetric(
                      vertical: padding20,
                      horizontal: padding20,
                    ),
                  ),
                  locationPicker("Tujuan", arrival),
                ],
              ),
              Positioned(
                right: 0,
                top: 20,
                bottom: 20,
                child: Center(
                  child: Icon(
                    Icons.swap_vert,
                    color: black700_70,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: space150),
          // Button Cari Tiket
          CustomButton(
            onPressed: () {
              // nanti tinggal ganti logic ke Cubit / Navigator
            },
            child: const Text('Cari Tiket'),
          ),
        ],
      ),
    );
  }

  Widget locationPicker(String label, String value) {
    return Row(
      children: [
        Icon(
          Icons.location_on_outlined,
          color: black500,
          size: iconL,
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: xsMedium,
              ),
              SizedBox(height: 2),
              Text(
                value.isEmpty ? "Pilih $label" : value,
                style:smRegular,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget imageSlider() {
    final List<String> sliderImages = [
      'assets/images/banner1.png',
      'assets/images/banner2.png',
      'assets/images/banner3.png',
    ];

    return Padding(
      padding: EdgeInsets.symmetric(vertical: paddingS),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 190,
          autoPlay: true,
          enlargeCenterPage: true,
          viewportFraction: 0.9,
        ),
        items: sliderImages.map((img) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius100),
            child: Image.asset(
              img,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget menuFavorit() {
    final List<Map<String, dynamic>> menus = [
      {"icon": Icons.directions_bus, "title": "Tiket Bus"},
      {"icon": Icons.history, "title": "Riwayat"},
      {"icon": Icons.local_offer, "title": "Promo"},
      {"icon": Icons.help_outline, "title": "Bantuan"},
    ];

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: paddingL,
        vertical: paddingS,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: "Menu Favorit"),
          SizedBox(height: space150),
          LayoutBuilder(
            builder: (context, constraints) {
              double maxWidth = constraints.maxWidth;
              int crossAxisCount = (maxWidth / 87).floor().clamp(2, 4);
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: menus.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 5,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (_, i) {
                  return Column(
                    children: [
                      Container(
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: gradientMenu,
                        ),
                        child: Center(
                          child: Icon(
                            menus[i]["icon"] as IconData,
                            color: black00,
                          ),
                        ),
                      ),
                      SizedBox(height: space150),
                      Container(
                        constraints: const BoxConstraints(maxHeight: 32),
                        alignment: Alignment.center,
                        child: Text(
                          menus[i]["title"] as String,
                          style: xsMedium,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _promoCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: paddingL),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: gradientPromo,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Bagaimana Perjalananmu?",
                  style: xlMedium,
                ),
                SizedBox(height: space150),
                Text(
                  "Berikan review untuk pengalaman perjalananmu bersama New Shantika",
                  style: smMedium,
                ),
                SizedBox(height: space150),
                // ReuseButton(
                //   text: "Beri Review",
                //   isFullWidth: false,
                //   onPressed: () {},
                //   backgroundColor: AppStyles.light,
                //   textColor: AppStyles.primary,
                //   borderColor: AppStyles.primary,
                //   fontSize: 12,
                //   width: 109,
                //   // height: 28,
                // ),
                CustomButton(
                  onPressed: () {},
                  child: Text('Beri Review'),
                ),
              ],
            ),
          ),
          SizedBox(width: space150),
          Image.asset(
            "images/stars.png",
            width: 80,
            height: 80,
          ),
        ],
      ),
    );
  }
  Widget _riwayats() {
    // dummy data
    final history = [
      {
        "title": "Perjalanan ke Bandung",
        "date": "12 Okt 2025",
        "from": "Jakarta",
        "to": "Bandung",
        "price": "150.000"
      },
      {
        "title": "Perjalanan ke Surabaya",
        "date": "20 Okt 2025",
        "from": "Yogyakarta",
        "to": "Surabaya",
        "price": "200.000"
      },
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SectionTitle(title: "Riwayat"),
              Spacer(),
              Text(
                "Lihat Semua",
                style: smMedium,
              ),
            ],
          ),
          Column(
            children: history.map((item) {
              return CustomCardContainer(
                margin: EdgeInsets.symmetric(vertical: space150),
                padding: EdgeInsets.all(paddingM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title + Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item["title"] ?? "",
                            style: xlMedium),
                        ),
                        // ReuseButton(
                        //   text: "Beri Review",
                        //   fontSize: 12,
                        //   radius: 20,
                        //   contentPadding: EdgeInsets.symmetric(
                        //       vertical: 6, horizontal: 20),
                        //   isFullWidth: false,
                        //   onPressed: () {},
                        // ),
                        CustomButton(
                          onPressed: () {},
                          child: Text('Beri Review'),
                        ),
                      ],
                    ),
                    Text(
                      item["date"] ?? "",
                      style: smMedium,
                    ),
                    SizedBox(height: space150),
                    // From
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.location_pin, color: black700_70),
                        SizedBox(width: space0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${item["from"]}", style: smMedium),
                            Text("05:30", style: smMedium),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: space600),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.location_pin, color: black700_70),
                        SizedBox(width: space0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${item["to"]}", style: smMedium),
                            Text("09:30", style: smMedium),
                          ],
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Rp ${item["price"]}",
                        style:smRegular,
                      ),
                    ),
                    SizedBox(height: space600),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _promoSection() {
    // dummy data
    final promoList = [
      {
        "title": "Diskon 50% Tiket Kereta!",
        "subtitle": "Nikmati perjalanan hemat ke seluruh Indonesia.",
        "date": "Berlaku hingga 31 Okt 2025",
        "imagePath": "assets/images/promo1.jpg",
      },
      {
        "title": "Promo Akhir Tahun",
        "subtitle": "Potongan harga untuk rute favorit kamu.",
        "date": "Berlaku hingga 30 Des 2025",
        "imagePath": "assets/images/promo2.jpg",
      },
    ];

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: paddingL,
        vertical: padding20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SectionTitle(title: "Promo"),
              Spacer(),
              Text(
                "Lihat Semua",
                style: smMedium,
              ),
            ],
          ),
          SizedBox(height: space600),
          SizedBox(
            height: 245,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: promoList.length,
              separatorBuilder: (_, __) => SizedBox(width: 12),
              itemBuilder: (context, index) {
                final promo = promoList[index];
                return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: _promoItem(
                    title: promo["title"]!,
                    subtitle: promo["subtitle"]!,
                    date: promo["date"]!,
                    imagePath: promo["imagePath"]!,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _promoItem({
    required String title,
    required String subtitle,
    required String date,
    required String imagePath,
  }) {
    return CustomCardContainer(
      margin: EdgeInsets.symmetric(vertical: space600),
      padding: EdgeInsets.zero,
      borderRadius: borderRadius100,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(borderRadius100),
              topRight: Radius.circular(borderRadius100),
            ),
            child: Image.asset(
              imagePath,
              height: 130,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: EdgeInsets.all(paddingM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: space600),
                Text(
                  title,
                  style: smMedium,
                ),
                SizedBox(height: space600),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        subtitle,
                        style: sMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: space150),
                    Icon(
                      Icons.calendar_month_rounded,
                      size: iconL,
                      color: black500,
                    ),
                    SizedBox(width: 4),
                    Text(
                      date,
                      style: xsSemiBold,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _artikelSection() {
    // dummy data
    final articles = [
      {
        "image": "assets/images/artikel1.jpg",
        "title": "Tips Aman Bepergian Jarak Jauh",
      },
      {
        "image": "assets/images/artikel2.jpg",
        "title": "5 Cara Nikmati Liburan Naik Bus",
      },
      {
        "image": "assets/images/artikel3.jpg",
        "title": "Promo Tiket Akhir Tahun!",
      },
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingL, vertical: space150),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Row(
            children: [
              SectionTitle(title: "Artikel"),
              Spacer(),
              GestureDetector(
                onTap: () {},
                child: Text("Lihat Semua", style: xsSemiBold),
              ),
            ],
          ),
          SizedBox(height: space150),

          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return _artikelCard(
                  imageUrl: article["image"] ?? "",
                  title: article["title"] ?? "",
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _artikelCard({required String imageUrl, required String title}) {
    return Container(
      width: 145,
      margin: EdgeInsets.only(right: paddingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius100),
            child: Image.asset(
              imageUrl,
              height: 140,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: space150),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: padding20),
            child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: smMedium
            ),
          ),
        ],
      ),
    );
  }

  Widget _testimoni() {
    // dummy data
    final List<Map<String, dynamic>> testimonials = [
      {
        "name": "Budi Santoso",
        "date": "25 Okt 2025",
        "busClass": "Eksekutif",
        "rating": 4,
        "review": "Perjalanannya nyaman banget, supirnya ramah.",
        "images": [
          "assets/images/testi1.jpg",
          "assets/images/testi2.jpg",
          "assets/images/testi3.jpg",
        ],
      },
      {
        "name": "Siti Aminah",
        "date": "20 Okt 2025",
        "busClass": "VIP",
        "rating": 5,
        "review": "Bus bersih, AC dingin, dan tepat waktu!",
        "images": ["assets/images/testi4.jpg"],
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingM),
          child: Row(
            children: [
              SectionTitle(title: "Testimoni"),
              Spacer(),
              Text("Lihat Semua", style: smMedium),
            ],
          ),
        ),
        Column(
          children: testimonials.map((t) {
            final String name = t["name"] as String? ?? "";
            final String date = t["date"] as String? ?? "";
            final String busClass = t["busClass"] as String? ?? "";
            final int rating = t["rating"] as int? ?? 0;
            final String review = t["review"] as String? ?? "";
            final List<String> images =
                (t["images"] as List<dynamic>?)?.map((e) => e as String).toList() ?? [];

            return CustomCardContainer(
              margin: EdgeInsets.symmetric(vertical: paddingS, horizontal: paddingM),
              padding: EdgeInsets.all(paddingM),
              borderRadius: borderRadius100,
              backgroundColor: black00,
              boxShadow: [
                BoxShadow(
                  color: black500.withOpacity(0.2),
                  blurRadius: borderRadius100,
                  offset: Offset(0, 2),
                ),
              ],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama + Tanggal
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(name, style: smMedium),
                      Text(date, style: smMedium),
                    ],
                  ),
                  SizedBox(height: space150),

                  // Kelas Bus
                  Text(busClass, style: smMedium),
                  SizedBox(height: space150),

                  // Rating
                  Row(
                    children: List.generate(
                      5,
                          (i) => Icon(
                        Icons.star,
                        color: i < rating ? Colors.amber : black50,
                        size: iconM,
                      ),
                    ),
                  ),
                  SizedBox(height: space150),

                  // Review
                  Text(review, style: smMedium),
                  SizedBox(height: space150),

                  // Foto testimoni kecil
                  if (images.isNotEmpty)
                    Row(
                      children: [
                        ...images.take(3).map((img) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                img,
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }),
                        if (images.length > 3)
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: black700_70,
                              borderRadius: BorderRadius.circular(borderRadius100),
                            ),
                            child: Center(
                              child: Text("+${images.length - 3}", style: smMedium),
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTestimoniView(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingL),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SectionTitle(title: "Testimoni"),
              Text(
                "Lihat Semua",
                style: smMedium,
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.37,
            child: ListView.separated(
              itemCount: 3,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: space150,
                );
              },
              itemBuilder: (BuildContext context, int index) {
                return CustomCardContainer(
                  width: 320,
                  margin: EdgeInsets.only(bottom: padding16),
                  borderColor: black00,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Esther Howard",
                            style: smMedium,
                          ),
                          Text(
                            "13 Feb 2025",
                            style: smMedium,
                          ),
                        ],
                      ),
                      SizedBox(height: space150),
                      Text(
                        "Super Executive",
                        style: smMedium,
                      ),
                      SizedBox(height: space600),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: primaryColor700,
                            size: iconM,
                          ),
                          Icon(
                            Icons.star,
                            color: primaryColor700,
                            size: iconM,
                          ),
                          Icon(
                            Icons.star,
                            color: primaryColor700,
                            size: iconM,
                          ),
                          Icon(
                            Icons.star,
                            color: primaryColor700,
                            size: iconM,
                          ),
                          Icon(
                            Icons.star,
                            color: primaryColor700,
                            size: iconM,
                          ),
                        ],
                      ),
                      SizedBox(height: space600),
                      Text(
                        "Sangat menyenangkan melakukan perjalanan bersama bus Shantika. Supirnya baik dan ramah, ACnya dingin, dan saya bisa tertidur pulas.",
                        style: sMedium,
                      ),
                      SizedBox(height: space600),
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              "images/testimoni.png",
                              width: 35,
                              height: 35,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: space050),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              "images/testimoni.png",
                              width: 35,
                              height: 35,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: space600),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              "images/testimoni.png",
                              width: 35,
                              height: 35,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: space600),
                          Align(
                            alignment: Alignment.center,
                            child: Text("+2", style: smMedium),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
