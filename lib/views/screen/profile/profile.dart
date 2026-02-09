import 'package:flutter/material.dart';
import 'package:flutter_extension/controller/chat_controller.dart';
import 'package:flutter_extension/data/model/user_model.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/style.dart';
import 'package:flutter_extension/views/base/bottom_sheet.dart';
import 'package:flutter_extension/views/screen/auth/login.dart';
import 'package:flutter_extension/views/screen/common/notification.dart';
import 'package:flutter_extension/views/screen/profile/booking_history.dart';
import 'package:flutter_extension/views/screen/profile/choose_language.dart';
import 'package:flutter_extension/views/screen/profile/profile_information.dart';
import 'package:flutter_extension/views/screen/profile/settings.dart';
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
      body: Column(
        children: [
          _appBar(),
          const SizedBox(height: 24),

          Column(
            children: [
              const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage("assets/images/profile.png"),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Samuel Nguyen",
                    style: AppTextStyles.display24(
                      color: AppColors.black,
                      weight: AppTextStyles.medium,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(width: 4),
                  SvgPicture.asset(
                    "assets/icons/crown.svg",
                    width: 24,
                    height: 24,
                  ),
                ],
              ),
              const SizedBox(height: 40),
              _buttonCard(
                () {
                  Get.to(
                    () => ProfileInformation(
                      user: UserModel(
                        name: "Samuel Nguyen",
                        email: "name@example.com",
                        profile: "assets/images/profile.png",
                      ),
                    ),
                  );
                },
                "profile",
                "Profile Information",
              ),
              _buttonCard(
                () {
                  Get.to(() => const BookingHistory());
                },
                "booking_history",
                "Booking History",
              ),
              _buttonCard(
                () {
                  Get.to(() => ChooseLanguage());
                },
                "language",
                "Language",
              ),
              _buttonCard(
                () {
                  Get.to(() => SettingsScreen());
                },
                "settings",
                "Settings",
              ),
              _buttonCard(
                () {
                  showLogoutBottomSheet(
                    context,
                    () {
                      Get.to(() => const LoginScreen());
                    },
                    "Are you sure you want to log out?",
                    "Logout",
                    "Yes, Logout",
                  );
                },
                "logout",
                "Logout",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding _buttonCard(VoidCallback onTap, String assets, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              height: 64,
              width: double.infinity,

              color: AppColors.background,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/$assets.svg",
                      width: 24,
                      height: 24,
                      // ignore: deprecated_member_use
                      color: AppColors.grey[700],
                    ),
                    const SizedBox(width: 8),
                    Text(
                      title,
                      style: AppTextStyles.text16(
                        color: AppColors.grey[700],
                        weight: AppTextStyles.regular,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(height: 1, color: AppColors.blue[100]),
          ],
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
