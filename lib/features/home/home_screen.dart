import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shantika_cubit/features/home/artikel_screen.dart';
import 'package:shantika_cubit/features/home/cubit/artikel_cubit.dart';
import 'package:shantika_cubit/features/home/notification_screen.dart';
import '../../config/constant.dart';
import '../../config/service_locator.dart';
import '../../config/user_preference.dart';
import '../../model/user_model.dart';
import '../../ui/color.dart';
import '../../ui/dimension.dart';
import '../../ui/shared_widget/circle_image_view.dart';
import '../../ui/shared_widget/custom_button.dart';
import '../../ui/shared_widget/custom_card_container.dart';
import '../../ui/shared_widget/custom_title.dart';
import '../../ui/typography.dart';
import 'cubit/home_cubit.dart';

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
                SizedBox(height: space3200),
                imageSlider(),
                SizedBox(height: spacing6),
                menuFavorit(),
                SizedBox(height: space600),
                _promoCard(),
                SizedBox(height: space600),
                _riwayats(),
                _promoSection(),
                _artikelSection(),
                SizedBox(height: spacing6),
                _buildTestimoniView(context),
                SizedBox(height: space600),
              ],
            ),
          ),
        ),
      ),
    );
  }

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
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 0, left: 16, right: 16, bottom: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Image.asset(
                      "assets/images/img_logo_shantika.png",
                      height: 24,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NoticationsPage(),
                      ),
                    );                  },
                  child: Icon(
                    Icons.notifications,
                    color: black00,
                    size: 28,
                  ),
                ),
              ],
            ),
          ),
        ),

        Positioned(
          bottom: -190,
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
      borderRadius: borderRadius300,
      padding: EdgeInsets.all(paddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Center(
            child: Text(
              "Cari Tiket Bus",
              style: smSemiBold,
            ),
          ),
          SizedBox(height: space1000),
          Stack(
            children: [
              Column(
                children: [
                  locationPicker("Keberangkatan", departure),
                  Container(
                    height: 1,
                    color: black950_10,
                    margin: EdgeInsets.symmetric(
                      vertical: padding12,
                      horizontal: space800,
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
          SizedBox(height: space1000),
          // Button Cari Tiket
          CustomButton(
            onPressed: () {},
            backgroundColor: primaryColor,
            child: Text('Cari Tiket'),
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
          color: iconBlack,
          size: iconL,
        ),
        SizedBox(width: space200),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: xsRegular,
              ),
              SizedBox(height: space100),
              Text(
                value.isEmpty ? "Pilih $label" : value,
                style:smMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget imageSlider() {
    final List<String> sliderImages = [
      'assets/images/red_bus.png',
      'assets/images/red_bus.png',
      'assets/images/red_bus.png',
    ];

    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding16),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 200,
          autoPlay: true,
          enlargeCenterPage: true,
          viewportFraction: 0.9,
        ),
        items: sliderImages.map((img) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius300),
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
      {"iconPath": "assets/images/tiket_pesanan.png", "title": "Pesan Tiket"},
      {"iconPath": "assets/images/buss.png", "title": "Informasi Kelas Armada"},
      {"iconPath": "assets/images/gedung.png", "title": "Informasi Perusahaan"},
      {"iconPath": "assets/images/cart.png", "title": "New Shantika Shop"},
      {"iconPath": "assets/images/sosmed.png", "title": "Sosial Media"},
      {"iconPath": "assets/images/agen.png", "title": "Informasi Agen"},
      {"iconPath": "assets/images/membership.png", "title": "E-Membership"},
      {"iconPath": "assets/images/website.png", "title": "Website"},
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
          SizedBox(height: spacing4),
          LayoutBuilder(
            builder: (context, constraints) {
              double maxWidth = constraints.maxWidth;
              int crossAxisCount = (maxWidth / 87).floor().clamp(2, 4);
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: menus.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
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
                          child: Image.asset(
                            menus[i]["iconPath"],
                            width: 55,
                            height: 55,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(height: space100),
                      Container(
                        constraints: BoxConstraints(maxHeight: 32),
                        alignment: Alignment.center,
                        child: Text(
                          menus[i]["title"],
                          style: xxsRegular,
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
      padding: EdgeInsets.all(padding16),
      decoration: BoxDecoration(
        gradient: gradientPromo,
        borderRadius: BorderRadius.circular(borderRadius300),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Bagaimana Perjalananmu?",
                  style: xsSemiBold.copyWith(color: black00),
                ),
                SizedBox(height: space100),
                Text(
                  "Berikan review untuk pengalaman perjalananmu bersama New Shantika",
                  style: xxsRegular.copyWith(color: black00),
                ),
                SizedBox(height: spacing4),
                SizedBox(
                  width: 90,
                  height: 28,
                  child: CustomButton(
                    onPressed: () {},
                    backgroundColor: black00,
                    child: Text(
                      'Beri Review',
                      style: xxsMedium.copyWith(color: black950),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: space150),
          Image.asset(
            "assets/images/stars.png",
            width: 80,
            height: 80,
          ),
        ],
      ),
    );
  }

  Widget _riwayats() {
    final history = [
      {
        "title": "Bus 10 • Executive Big Top",
        "date": "11 Februari 2025  • 20:30",
        "from": "Krapyak - Semarang",
        "to": "Gejayan - Sleman",
        "price": "230.000"
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
                style: smMedium.copyWith(color: navy400),
              ),
            ],
          ),
          Column(
            children: history.map((item) {
              return CustomCardContainer(
                borderRadius: borderRadius300,
                margin: EdgeInsets.symmetric(vertical: paddingS),
                padding: EdgeInsets.all(padding12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item["title"] ?? "",
                            style: smMedium),
                        ),
                        SizedBox(
                          width: 95,
                          height: 30,
                          child: CustomButton(
                            onPressed: () {},
                            backgroundColor: navy600,
                            child: Text(
                              'Beri Review',
                              style: xsMedium.copyWith(color: black00),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      item["date"] ?? "",
                      style: xsRegular.copyWith(color: black400),
                    ),
                    SizedBox(height: spacing4),
                    // From
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.location_pin, color: black700_70),
                        SizedBox(width: space200),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${item["from"]}", style: xsMedium),
                            SizedBox(height: space150),
                            Text("05:30", style: xxsRegular),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: spacing4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.location_pin, color: navy400),
                        SizedBox(width: space200),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${item["to"]}", style: xsMedium),
                            SizedBox(height: space150),
                            Text("09:30", style: xxsRegular),
                          ],
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Rp ${item["price"]}",
                        style:mdSemiBold.copyWith(color: navy400),
                      ),
                    ),
                    SizedBox(height: spacing5),
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
        "title": "Promo Mudik 2024",
        "subtitle": "Potongan hingga Rp50.000",
        "date": "28 April 2025",
        "imagePath": "assets/images/promo.png",
      },
      {
        "title": "Promo Mudik 2024",
        "subtitle": "Potongan hingga Rp50.000",
        "date": "28 April 2025",
        "imagePath": "assets/images/promo.png",
      },
    ];

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: padding16,
        vertical: paddingS,
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
                style: smMedium.copyWith(color: navy400),
              ),
            ],
          ),
          // SizedBox(height: spacing6),
          SizedBox(
            height: 260,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: promoList.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
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
      borderRadius: borderRadius500,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(borderRadius500),
              topRight: Radius.circular(borderRadius500),
            ),
            child: Image.asset(
              imagePath,
              height: 130,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: EdgeInsets.all(padding12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: spacing2),
                Text(
                  title,
                  style: smMedium,
                ),
                SizedBox(height: spacing2),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        subtitle,
                        style: xsRegular.copyWith(color: navy400),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: space250),
                    Icon(Icons.calendar_month, size: iconM, color: black500),
                    SizedBox(width: space100),
                    Text(
                      date,
                      style: xsSemiBold,
                      overflow: TextOverflow.ellipsis,
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
        "image": "assets/images/artikel1.png",
        "title": "Tips Aman Bepergian Jarak Jauh",
      },
      {
        "image": "assets/images/artikel2.png",
        "title": "5 Cara Nikmati Liburan Naik Bus",
      },
      {
        "image": "assets/images/artikel3.png",
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => ArtikelCubit(),
                        child: ArtikelScreen(),
                      ),
                    ),
                  );
                },
                child: Text("Lihat Semua", style: smMedium.copyWith(color: navy400)),
              ),
            ],
          ),
          SizedBox(height: spacing6),
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
      width: 157,
      margin: EdgeInsets.only(right: padding12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius300),
            child: Image.asset(
              imageUrl,
              height: 157,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: space200),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: space100),
            child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: xsMedium
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestimoniView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingL),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SectionTitle(title: "Testimoni"),
              Text(
                "Lihat Semua",
                style: smMedium.copyWith(color: navy400),
              ),
            ],
          ),
        ),
        SizedBox(height: spacing5),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.33,
          child: ListView.separated(
            itemCount: 3,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: padding20),
            separatorBuilder: (context, index) => SizedBox(width: spacing4),
            itemBuilder: (BuildContext context, int index) {
              return CustomCardContainer(
                width: MediaQuery.of(context).size.width * 0.9,
                borderRadius: borderRadius300,
                margin: EdgeInsets.only(bottom: padding12),
                borderColor: black00,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Esther Howard", style: smMedium),
                        Text("13 Feb 2025", style: xsRegular),
                      ],
                    ),
                    SizedBox(height: spacing5),
                    Text("Super Executive", style: xsRegular),
                    SizedBox(height: space200),
                    Row(
                      children: List.generate(5, (i) {
                        return Icon(Icons.star, color: yellow500, size: iconM);
                      }),
                    ),
                    SizedBox(height: spacing3),
                    Text(
                      "Sangat menyenangkan melakukan perjalanan bersama bus Shantika. Supirnya baik dan ramah, ACnya dingin, dan saya bisa tertidur pulas.",
                      style: smRegular,
                    ),
                    SizedBox(height: space200),
                    Row(
                      children: [
                        ...List.generate(3, (i) {
                          return Padding(
                            padding: EdgeInsets.only(right: space100),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(borderRadius200),
                              child: Image.asset(
                                "assets/images/testimoni.png",
                                width: 35,
                                height: 35,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }),
                        SizedBox(width: space200),
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
    );
  }
}
