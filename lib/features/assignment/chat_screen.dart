import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shantika_cubit/features/assignment/cubit/chat_cubit.dart';
import 'package:shantika_cubit/features/assignment/cubit/chat_state.dart';
import 'package:shantika_cubit/model/response/chat_response.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../config/constant.dart';
import '../../ui/color.dart';
import '../../ui/dimension.dart';
import '../../ui/shared_widget/custom_card_container.dart';
import '../../ui/typography.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    _loadChats();
  }

  void _loadChats() {
    context.read<ChatCubit>().fetchChats();
  }

  Future<void> _onRefresh() async {
    await context.read<ChatCubit>().refreshChats();
  }

  Future<void> _openLink(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Could not open link')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error opening link: $e')),
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
        child: BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) {
            if (state is ChatLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is ChatError) {
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
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            if (state is ChatLoaded) {
              if (state.chats.isEmpty) {
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
                  itemCount: state.chats.length,
                  separatorBuilder: (_, __) => SizedBox(height: spacing6),
                  itemBuilder: (context, index) {
                    final chat = state.chats[index];
                    return _chatCard(chat);
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
      preferredSize: const Size.fromHeight(kToolbarHeight + 4),
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
            "Chat",
            style: xlSemiBold,
          ),
          centerTitle: true,
        ),
      ),
    );
  }

  Widget _chatCard(ChatData chat) {
    return GestureDetector(
      onTap: () => _openLink(chat.link),
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
              child: _buildIcon(chat.icon),
            ),
            SizedBox(width: spacing4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chat.name,
                    style: mdRegular,
                  ),
                  if (chat.type.isNotEmpty) ...[
                    SizedBox(height: spacing2),
                    Text(
                      chat.type.toUpperCase(),
                      style: smRegular.copyWith(
                        color: black700_70,
                        fontSize: 11,
                      ),
                    ),
                  ],
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