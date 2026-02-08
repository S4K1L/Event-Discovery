import 'package:flutter/material.dart';
import 'package:flutter_extension/controller/chat_controller.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/views/screen/common/notification.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
      body: Column(children: [_appBar()]),
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
