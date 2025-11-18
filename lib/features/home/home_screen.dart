import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shantika_cubit/features/home/article/artikel_screen.dart';
import 'package:shantika_cubit/features/home/article/detail_artikel_screen.dart';
import 'package:shantika_cubit/features/home/books_ticket/pesan_tiket_screen.dart';
import 'package:shantika_cubit/features/home/cities/cubit/all_cities_cubit.dart';
import 'package:shantika_cubit/features/home/cities/list_cities_screen.dart';
import 'package:shantika_cubit/features/home/cubit/home_cubit.dart';
import 'package:shantika_cubit/features/home/cubit/home_state.dart';
import 'package:shantika_cubit/features/home/cities/info_agency_screen.dart';
import 'package:shantika_cubit/features/home/fleet/fleet_classes_screen.dart';
import 'package:shantika_cubit/features/home/notification_screen.dart';
import 'package:shantika_cubit/features/profile/faq_screen.dart';
import 'package:shantika_cubit/features/profile/notifications_profile_screen.dart';
import 'package:shantika_cubit/model/home_model.dart';
import 'package:shantika_cubit/repository/home_repository.dart';
import '../../ui/color.dart';
import '../../ui/dimension.dart';
import '../../ui/shared_widget/custom_button.dart';
import '../../ui/shared_widget/custom_card_container.dart';
import '../../ui/shared_widget/custom_title.dart';
import '../../ui/typography.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().fetchHomeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black00,
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return Center(
                child: CircularProgressIndicator(color: primaryColor),
              );
            }

            if (state is HomeError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 60, color: red100),
                    SizedBox(height: spacing4),
                    Text('Terjadi Kesalahan', style: lgSemiBold),
                    SizedBox(height: space200),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: paddingL),
                      child: Text(
                        state.message,
                        style: smRegular,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: space600),
                    ElevatedButton(
                      onPressed: () => context.read<HomeCubit>().fetchHomeData(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: EdgeInsets.symmetric(horizontal: paddingL, vertical: padding12),
                      ),
                      child: Text('Coba Lagi'),
                    ),
                  ],
                ),
              );
            }

            if (state is HomeLoaded) {
              return _buildMainView(context, state.data);
            }

            return Center(child: Text('Memuat data...'));
          },
        ),
      ),
    );
  }

  Widget _buildMainView(BuildContext context, HomeModel data) {
    return RefreshIndicator(
      onRefresh: () => context.read<HomeCubit>().refreshHomeData(),
      color: primaryColor,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            _headerWithSearch(),
            SizedBox(height: space3200),
            _imageSlider(data.slider),
            SizedBox(height: spacing5),
            _menuFavorit(data.customerMenu),
            SizedBox(height: space600),

            if (data.pendingReviews.isNotEmpty) ...[
              _promoCard(),
              SizedBox(height: space600),
              _riwayats(data.pendingReviews),
              SizedBox(height: spacing4),
            ],

            _promoBanner(data.promo),
            SizedBox(height: space600),
            // if (data.promo.isNotEmpty) ...[
            //   _promoBanner(data.promo),
            //   SizedBox(height: space600),
            // ],

            if (data.artikel.isNotEmpty) ...[
              _artikelSection(data.artikel),
              SizedBox(height: spacing4),
            ],

            _buildTestimoniView(context, data.testimonials),
            // SizedBox(height: space600),
          ],
        ),
      ),
    );
  }

  Widget _buildTestimoniView(BuildContext context, List<Testimonials> testimonies) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SectionTitle(title: "Testimoni"),
              Spacer(),
              GestureDetector(
                onTap: () {},
                child: Text("Lihat Semua", style: smMedium.copyWith(color: navy400)),
              ),
            ],
          ),
          SizedBox(height: spacing6),

          if (testimonies.isEmpty)
            Container(
              height: 180,
              decoration: BoxDecoration(
                color: black00,
                borderRadius: BorderRadius.circular(borderRadius300),
              ),
              child: Center(
                child: Text(
                  "Belum ada testimoni",
                  style: smMedium.copyWith(color: black400),
                ),
              ),
            ),
          if (testimonies.isNotEmpty)
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: testimonies.length > 3 ? 3 : testimonies.length,
              itemBuilder: (context, index) {
                final t = testimonies[index];
                return _testimoniCard(t);
              },
            ),
        ],
      ),
    );
  }

  Widget _testimoniCard(Testimonials t) {
  return CustomCardContainer(
    margin: EdgeInsets.only(bottom: padding12),
    borderRadius: borderRadius300,
    padding: EdgeInsets.all(paddingL),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(t.title, style: smMedium),
        SizedBox(height: spacing2),

        // Nama customer
        Text(t.nameCustomer, style: xsRegular.copyWith(color: black400)),
        SizedBox(height: spacing2),

        // Review text
        Text(
          t.review,
          style: smRegular,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: spacing3),

        Align(
          alignment: Alignment.centerRight,
          child: Text(
            t.createdAt,
            style: xsRegular.copyWith(color: black400),
          ),
        ),
      ],
    ),
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
                    );
                  },
                  child: Icon(Icons.notifications, color: black00, size: 28),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: -190,
          left: 16,
          right: 16,
          child: _searchTicket(),
        ),
      ],
    );
  }

  Widget _searchTicket() {
    return CustomCardContainer(
      borderRadius: borderRadius300,
      padding: EdgeInsets.all(paddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Text("Cari Tiket Bus", style: smSemiBold)),
          SizedBox(height: space1000),
          Stack(
            children: [
              Column(
                children: [
                  _locationPicker("Keberangkatan", ""),
                  Container(
                    height: 1,
                    color: black950_10,
                    margin: EdgeInsets.symmetric(
                      vertical: padding12,
                      horizontal: space800,
                    ),
                  ),
                  _locationPicker("Tujuan", ""),
                ],
              ),
              Positioned(
                right: 0,
                top: 20,
                bottom: 20,
                child: Center(
                  child: Icon(Icons.swap_vert, color: black700_70),
                ),
              ),
            ],
          ),
          SizedBox(height: space1000),
          CustomButton(
            onPressed: () {},
            padding: EdgeInsets.symmetric(vertical: padding12),
            backgroundColor: primaryColor,
            child: Text('Cari Tiket'),
          ),
        ],
      ),
    );
  }

  Widget _locationPicker(String label, String value) {
    return Row(
      children: [
        Icon(Icons.location_on_outlined, color: iconBlack, size: iconL),
        SizedBox(width: space200),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: xsRegular),
              SizedBox(height: space100),
              Text(value.isEmpty ? "Pilih $label" : value, style: smMedium),
            ],
          ),
        ),
      ],
    );
  }

  Widget _imageSlider(List<Artikel> sliders) {
    if (sliders.isEmpty) return SizedBox.shrink();
    return SizedBox(
      child: CarouselSlider.builder(
        itemCount: sliders.length,
        itemBuilder: (context, index, realIndex) {
          final slider = sliders[index];

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: padding16, vertical: padding16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius300),
              child: CachedNetworkImage(
                imageUrl: slider.image,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: black700_70,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                      strokeWidth: 2,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: black700_70,
                  alignment: Alignment.center,
                  child: Text("Image tidak bisa diload", style: smMedium),
                  // child: Image.asset('assets/images/red_bus.png'),
                ),
              ),
            ),
          );
        },
        options: CarouselOptions(
          height: 200,
          autoPlay: true,
          viewportFraction: 1,
          autoPlayInterval: Duration(seconds: 3),
          enlargeCenterPage: false,
        ),
      ),
    );
  }

  Widget _menuFavorit(List<CustomerMenu> menus) {
    if (menus.isEmpty) return SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingL, vertical: paddingS),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: "Menu Favorit"),
          SizedBox(height: spacing4),
          GridView.builder(
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
              final menu = menus[i];
              return GestureDetector(
                onTap: () {
                  print('Menu clicked: ${menu.name} (${menu.id})');

                  switch (menu.id) {
                    case 1:
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PesanTiketScreen()),
                      );
                      break;


                      case 2:
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => InfoFleetClasses()),
                      );
                      break;

                    case 6:
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider.value(
                            value: context.read<AllCitiesCubit>(),
                            child: ListCitiesScreen(),
                          ),
                        ),
                      );
                      break;

                    default:
                      print('Belum ada page untuk menu id: ${menu.id}');
                  }
                },
                child: Column(
                  children: [
                    Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: gradientMenu,
                      ),
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: menu.icon,
                          width: 55,
                          height: 55,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                              strokeWidth: 2,
                            ),
                          ),
                          errorWidget: (context, url, error) => Icon(
                            Icons.apps,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: space100),
                    Container(
                      constraints: BoxConstraints(maxHeight: 32),
                      alignment: Alignment.center,
                      child: Text(
                        menu.name,
                        style: xxsRegular,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
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
          Image.asset("assets/images/stars.png", width: 80, height: 80),
        ],
      ),
    );
  }

  Widget _riwayats(List<PendingReview> reviews) {
    if (reviews.isEmpty) return SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.only(bottom: space200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingL),
            child: Row(
              children: [
                SectionTitle(title: "Riwayat"),
                Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Lihat Semua",
                    style: smMedium.copyWith(color: navy400),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spacing4),
          SizedBox(
            height: 200,
            child: PageView.builder(
              controller: PageController(viewportFraction: 0.92),
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                final review = reviews[index];
                return Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? padding16 : spacing2,
                    right: index == reviews.length - 1 ? padding16 : spacing2,
                  ),
                  child: CustomCardContainer(
                    boxShadow: [],
                    borderRadius: borderRadius300,
                    borderColor: black100,
                    backgroundColor: black00,
                    padding: EdgeInsets.all(padding12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "${review.nameFleet} • ${review.fleetClass}",
                                style: smMedium,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: space300),
                            SizedBox(
                              height: 30,
                              child: CustomButton(
                                onPressed: () {},
                                borderRadius: borderRadius750,
                                backgroundColor: navy600,
                                child: Text(
                                  'Beri Review',
                                  style: xsMedium.copyWith(color: black00),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spacing4),
                        Text(
                          "${review.createdAt} • ${review.departureAt}",
                          style: xsRegular.copyWith(color: black400),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: spacing4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Icon(Icons.location_pin, color: black700_70, size: 18),
                                SizedBox(height: space150),
                                Container(
                                  width: 1.5,
                                  height: 12,
                                  color: black400.withOpacity(0.3),
                                ),
                                SizedBox(height: space150),
                              ],
                            ),
                            SizedBox(width: space100),
                            Expanded(
                              child: Text(
                                "${review.checkpoints.start.agencyName} - ${review.checkpoints.start.cityName}",
                                style: xsMedium,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.location_pin, color: navy400, size: 18),
                            SizedBox(width: space100),
                            Expanded(
                              child: Text(
                                "${review.checkpoints.destination.agencyName} - ${review.checkpoints.destination.cityName}",
                                style: xsMedium,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spacing3),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Rp ${_formatPrice(review.price)}",
                            style: mdSemiBold.copyWith(color: navy400),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _promoBanner(List<String> promos) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingL, vertical: space150),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SectionTitle(title: "Promo"),
              Spacer(),
              GestureDetector(
                onTap: () {},
                child: Text("Lihat Semua", style: smMedium.copyWith(color: navy400)),
              ),
            ],
          ),
          SizedBox(height: spacing4),
          promos.isEmpty
              ? Container(
            height: 180,
            decoration: BoxDecoration(
              color: black00,
              borderRadius: BorderRadius.circular(borderRadius300),
            ),
            child: Center(
              child: Text(
                "Promo masih kosong",
                style: smMedium.copyWith(color: black400),
              ),
            ),
          )
              : CarouselSlider.builder(
            itemCount: promos.length,
            itemBuilder: (context, index, realIndex) {
              final image = promos[index];
              return ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius300),
                child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                ),
              );
            },
            options: CarouselOptions(
              height: 180,
              autoPlay: true,
              viewportFraction: 0.92,
              enlargeCenterPage: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _artikelSection(List<Artikel> articles) {
    if (articles.isEmpty) return SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingL, vertical: space150),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SectionTitle(title: "Artikel"),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ArtikelScreen(),
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
                  imageUrl: article.image,
                  title: article.name,
                  article: article,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _artikelCard({
    required String imageUrl,
    required String title,
    required Artikel article,
  }) {
    return Container(
      width: 157,
      margin: EdgeInsets.only(right: padding12),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailArtikelScreen(articleId: article.id),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius300),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                height: 157,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: black750,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                      strokeWidth: 2,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: black750,
                  child: Icon(Icons.article, size: 50),
                ),
              ),
            ),
            SizedBox(height: space200),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: space100),
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: xsMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
    );
  }
}