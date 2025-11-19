import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shantika_cubit/features/home/social_media/cubit/social_media_cubit.dart';
import 'package:shantika_cubit/features/home/social_media/cubit/social_media_state.dart';
import 'package:shantika_cubit/model/social_media_model.dart';
import 'package:shantika_cubit/ui/shared_widget/custom_card_container.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../ui/color.dart';
import '../../../ui/dimension.dart';
import '../../../ui/typography.dart';

class SocialMediaScreen extends StatefulWidget {
  const SocialMediaScreen({super.key});

  @override
  State<SocialMediaScreen> createState() => _SocialMediaScreenState();
}

class _SocialMediaScreenState extends State<SocialMediaScreen> {
  @override

  void initState() {
    super.initState();
    _loadChats();
  }

  void _loadChats() {
    context.read<SocialMediaCubit>().loadSocialMedia();
  }

  Future<void> _onRefresh() async {
    await context.read<SocialMediaCubit>().refreshSocialMedia();
  }

  Future<void> _openLink(String value) async {
    try {
      final String cleanValue = value.trim();
      Uri uri;

      if (cleanValue.contains("@")) {
        uri = Uri.parse("mailto:$cleanValue");
      } else {
        uri = Uri.parse(cleanValue);
      }

      bool launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tidak bisa membuka link'),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error membuka link: $e'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black00,
      appBar: _header(),
      body: SafeArea(
        child: BlocBuilder<SocialMediaCubit, SocialMediaState>(
          builder: (context, state) {
            if (state is SocialMediaLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is SocialMediaError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: red100,
                    ),
                    SizedBox(height: spacing4),
                    Text(
                      'Error',
                      style: xlSemiBold,
                    ),
                    SizedBox(height: spacing2),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: paddingL),
                      child: Text(
                        state.message,
                        style: mdRegular,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: spacing6),
                    ElevatedButton.icon(
                      onPressed: _loadChats,
                      icon: Icon(Icons.refresh),
                      label: Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            if (state is SocialMediaLoaded) {
              if (state.socialMedia.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.chat_bubble_outline,
                        size: 64,
                        color: black700_70,
                      ),
                      SizedBox(height: spacing4),
                      Text(
                        'No chat contacts available',
                        style: mdRegular.copyWith(
                          color: black700_70,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: _onRefresh,
                child: ListView.separated(
                  padding: EdgeInsets.all(paddingL),
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: state.socialMedia.length,
                  separatorBuilder: (_, __) => SizedBox(height: spacing6),
                  itemBuilder: (context, index) {
                    final chat = state.socialMedia[index];
                    return _socialMediaCard(chat);
                  },
                ),
              );
            }

            return SizedBox.shrink();
          },
        ),
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
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Social Media",
            style: xlSemiBold,
          ),
        ),
      ),
    );
  }

  Widget _socialMediaCard(SocialMedia socialMedia) {
    return GestureDetector(
      onTap: () => _openLink(socialMedia.value),
      child: CustomCardContainer(
        padding: EdgeInsets.symmetric(
          horizontal: padding16,
          vertical: padding12,
        ),
        borderRadius: borderRadius300,
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(space200),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius200),
              ),
              child: _buildIcon(socialMedia.icon),
            ),
            SizedBox(width: spacing4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    socialMedia.name,
                    style: mdRegular,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(String iconUrl) {
    if (iconUrl.startsWith('http')) {
      return Image.network(
        iconUrl,
        width: iconXL,
        height: iconXL,
        errorBuilder: (_, __, ___) => Icon(
          Icons.chat_bubble,
          size: iconXL,
          color: black700_70,
        ),
      );
    }

    if (iconUrl.endsWith('.svg')) {
      return SvgPicture.asset(
        iconUrl,
        width: iconXL,
        height: iconXL,
      );
    }

    return Image.asset(
      iconUrl,
      width: iconXL,
      height: iconXL,
      errorBuilder: (_, __, ___) => Icon(
        Icons.chat_bubble,
        size: iconXL,
        color: black700_70,
      ),
    );
  }
}
