import 'package:flutter/material.dart';
import 'package:flutter_extension/controller/chat_controller.dart';
import 'package:flutter_extension/data/model/chat_list_model.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/style.dart';
import 'package:flutter_extension/views/screen/common/notification.dart';
import 'package:flutter_extension/views/screen/message/inbox_screen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final ChatController chatController = Get.put(ChatController());

  @override
  void initState() {
    chatController.loadDummyChatList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _appBar(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Obx(() {
                final chats = chatController.chatsList;
                return RefreshIndicator(
                  color: AppColors.primary,
                  onRefresh: chatController.refreshCurrentTab,
                  child: chats.isEmpty
                      ? ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: const [
                            SizedBox(height: 200),
                            Center(child: Text("No chat's found")),
                          ],
                        )
                      : ListView.builder(
                          itemCount: chatController.chatsList.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            final chatModel = chatController.chatsList[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: _chatCard(() {
                                Get.to(
                                  () => InboxScreen(chatModel: chatModel),
                                  transition: Transition.rightToLeft,
                                );
                              }, chatModel),
                            );
                          },
                        ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector _chatCard(void Function() onTap, ChatListModel chatModel) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 76,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage(chatModel.image!),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          chatModel.name!,
                          style: AppTextStyles.text18(
                            color: AppColors.black,
                            weight: AppTextStyles.medium,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),
                        Text(
                          chatModel.time!,
                          style: AppTextStyles.text12(
                            color: AppColors.grey[600],
                            weight: AppTextStyles.regular,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          chatModel.lastMessage!,
                          style: AppTextStyles.text12(
                            color: AppColors.black,
                            weight: AppTextStyles.regular,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),
                        if (chatModel.count != 0) ...[
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: AppColors.primary,
                            child: Text(
                              chatModel.count.toString(),
                              style: AppTextStyles.text12(
                                color: AppColors.white,
                                weight: AppTextStyles.regular,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _appBar() {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        color: AppColors.primary,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/splash3.png",
              width: 120,
              height: 48,
              color: AppColors.white,
            ),
            const Spacer(),
            InkWell(
              onTap: () => Get.to(
                () => NotificationScreen(),
                transition: Transition.rightToLeft,
              ),
              child: SvgPicture.asset(
                "assets/icons/notification.svg",
                width: 24,
                height: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
