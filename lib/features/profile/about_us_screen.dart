import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shantika_cubit/features/profile/cubit/about_us_cubit.dart';
import 'package:shantika_cubit/features/profile/cubit/about_us_state.dart';
import 'package:shantika_cubit/ui/color.dart';
import 'package:shantika_cubit/ui/dimension.dart';
import 'package:shantika_cubit/ui/typography.dart';
import 'package:url_launcher/url_launcher.dart';

class TentangKamiPage extends StatefulWidget {
  const TentangKamiPage({super.key});

  @override
  State<TentangKamiPage> createState() => _TentangKamiPageState();
}

class _TentangKamiPageState extends State<TentangKamiPage> {
  @override
  void initState() {
    super.initState();
    context.read<AboutCubit>().fetchAbout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black00,
      appBar: _header(),
      body: BlocBuilder<AboutCubit, AboutState>(
        builder: (context, state) {
          if (state is AboutLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AboutError) {
            return const Center(child: Text("Gagal memuat data :("));
          }

          if (state is AboutLoaded) {
            final about = state.data;

            const title = "New Shantika";

            final description = (about.description.isNotEmpty)
                ? about.description
                : "New Shantika berkomitmen memberikan perjalanan yang aman, nyaman, dan terpercaya. Kami terus berkembang untuk meningkatkan layanan bagi seluruh penumpang.";

            return SingleChildScrollView(
              padding: EdgeInsets.all(padding20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: space600),
                  Text(
                    title,
                    style: xlSemiBold,
                  ),
                  SizedBox(height: space600),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(borderRadius300),
                    child: Image.network(
                      about.image,
                      width: double.infinity,
                    ),
                  ),
                  SizedBox(height: space600),
                  Text(
                    about.description.isNotEmpty ? about.description : '-',
                    style: smMedium,
                  ),
                  SizedBox(height: space600),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _socialMediaButton(
                        icon: Icons.facebook,
                        onTap: () => _launchUrl('https://instagram.com'),
                      ),
                      SizedBox(width: space1200),
                      _socialMediaButton(
                        icon: Icons.email_outlined,
                        onTap: () => _launchUrl('mailto:info@newshantika.com'),
                      ),
                      SizedBox(width: space1200),
                      _socialMediaButton(
                        icon: Icons.facebook,
                        onTap: () => _launchUrl('https://newshantika.com'),
                      ),
                    ],
                  ),
                  SizedBox(height: space600),
                  Text(
                    about.address,
                    style: mdMedium.copyWith(color: black750),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  PreferredSizeWidget _header() {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight + 4),
      child: Container(
        decoration: BoxDecoration(
          color: black00,
          boxShadow: [
            BoxShadow(
              color: black950.withOpacity(0.08),
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: black950),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text("Tentang Kami", style: xlMedium),
        ),
      ),
    );
  }

  Widget _socialMediaButton({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(borderRadius300),
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: primaryColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: black950.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: black00,
          size: iconL,
        ),
      ),
    );
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
    }
  }
}
