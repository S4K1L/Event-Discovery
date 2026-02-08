import 'package:flutter/material.dart';
import 'package:flutter_extension/controller/home_controller.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/style.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.blue[50],
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 18,
            color: AppColors.grey[600],
          ),
        ),
        title: Text(
          'Confirmation',
          style: AppTextStyles.text16(
            weight: AppTextStyles.semibold,
            color: AppColors.grey[700],
          ),
        ),
        centerTitle: true,
      ),

      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: homeController.notifications.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  final notification = homeController.notifications[index];

                  return Dismissible(
                    key: Key(notification.title + index.toString()),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      color: Colors.red,
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (_) {
                      homeController.deleteNotification(index);
                    },
                    child: GestureDetector(
                      onTap: () {
                        if (notification.unread) {
                          homeController.markAsRead(index);
                        }
                      },
                      child: notificationCard(
                        isUnread: notification.unread,
                        title: notification.title,
                        time: notification.timeAgo,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container notificationCard({bool? isUnread, String? title, String? time}) {
    return Container(
      height: 80,
      width: double.infinity,
      color: isUnread == true ? AppColors.blue[100] : AppColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: isUnread == true
                ? AppColors.white
                : AppColors.blue[50],
            child: SvgPicture.asset(
              "assets/icons/notification.svg",
              width: 24,
              height: 24,
              // ignore: deprecated_member_use
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title!,
                  style: AppTextStyles.text14(
                    color: AppColors.grey[600],
                    weight: AppTextStyles.regular,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/clock.svg",
                      width: 14,
                      height: 14,
                      color: AppColors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      time!,
                      style: AppTextStyles.text14(
                        color: AppColors.grey[600],
                        weight: AppTextStyles.regular,
                      ),
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
}
