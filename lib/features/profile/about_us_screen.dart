import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shantika_cubit/features/profile/cubit/about_us_cubit.dart';
import 'package:shantika_cubit/features/profile/cubit/about_us_state.dart';
import 'package:shantika_cubit/ui/color.dart';
import 'package:shantika_cubit/ui/dimension.dart';
import 'package:shantika_cubit/ui/typography.dart';

class TentangKamiPage extends StatefulWidget {
  const TentangKamiPage({super.key});

  @override
  State<TentangKamiPage> createState() => _TentangKamiPageState();
}

class _TentangKamiPageState extends State<TentangKamiPage> {
  @override
  void initState() {
    super.initState();
    context.read<AboutCubit>().fetchAbout(); // panggil sekali di awal
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

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      about.image,
                      width: double.infinity,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    about.description.isNotEmpty ? about.description : '-',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    about.address,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
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
              color: black700_70,
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
}
