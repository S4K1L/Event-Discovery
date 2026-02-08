import 'package:flutter/material.dart';
import 'package:flutter_extension/controller/chat_controller.dart';
import 'package:flutter_extension/data/model/chat_list_model.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/style.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class InboxScreen extends StatefulWidget {
  final ChatListModel chatModel;

  const InboxScreen({super.key, required this.chatModel});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  final ChatController controller = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _appBar(),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                reverse: true,
                controller: controller.scrollController,
                physics: const BouncingScrollPhysics(),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final message = controller
                      .messages[controller.messages.length - 1 - index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    child: buildMessageCard(
                      message: message.message,
                      time: message.formattedTime,
                      isMe: message.isMe,
                      isRead: message.isRead,
                    ),
                  );
                },
              ),
            ),
          ),
          messageInputField(),
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: true,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: Icon(
          Icons.arrow_back_ios_new,
          size: 18,
          color: AppColors.grey[600],
        ),
      ),
      title: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage(widget.chatModel.image!),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: CircleAvatar(
                  radius: 8,
                  backgroundColor: AppColors.white,
                  child: CircleAvatar(
                    radius: 6,
                    backgroundColor: widget.chatModel.isActive!
                        ? AppColors.green[600]
                        : AppColors.red[600],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              "${widget.chatModel.name}",
              style: AppTextStyles.text18(
                weight: FontWeight.bold,
                color: AppColors.grey[500],
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Padding messageInputField() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller.messageController,
              decoration: InputDecoration(
                hintText: 'Type your message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(71),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: AppColors.white,
                suffixIcon: IconButton(
                  onPressed: () => controller.sendMessage(),
                  icon: CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.primary,
                    child: SvgPicture.asset(
                      'assets/icons/send.svg',
                      height: 24,
                      width: 24,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMessageCard({
    required String message,
    required String time,
    bool isMe = false,
    bool isRead = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isMe ? const Color(0xFF2F80ED) : const Color(0xFFEDEFF3),
              borderRadius: BorderRadius.only(
                bottomLeft: const Radius.circular(32),
                bottomRight: const Radius.circular(32),
                topLeft: isMe
                    ? const Radius.circular(32)
                    : const Radius.circular(0),
                topRight: isMe
                    ? const Radius.circular(0)
                    : const Radius.circular(32),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  message,
                  style: AppTextStyles.text14(
                    color: isMe ? AppColors.white : AppColors.grey[600],
                    weight: AppTextStyles.regular,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  time,
                  style: AppTextStyles.text12(
                    color: isMe ? AppColors.white : AppColors.grey[600],
                    weight: AppTextStyles.regular,
                  ),
                ),
                if (isMe) ...[
                  const SizedBox(width: 4),
                  Icon(
                    Icons.done_all,
                    size: 20,
                    color: isRead ? AppColors.white : AppColors.blue[300],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
