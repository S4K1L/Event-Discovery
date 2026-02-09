import 'package:flutter/material.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/style.dart';
import 'package:flutter_extension/views/screen/profile/data_screen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.blue[50],
        elevation: 0,
        leading: IconButton(
          onPressed: Get.back,
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 18,
            color: AppColors.grey[600],
          ),
        ),
        title: Text(
          'Settings',
          style: AppTextStyles.text16(
            weight: AppTextStyles.semibold,
            color: AppColors.grey[700],
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _tabCard(
                () {
                  Get.to(
                    () => const DataScreen(
                      title: 'Terms of Service',
                      endPoint: 'terms',
                    ),
                  );
                },
                'Terms of Service',
                'terms',
              ),
              _tabCard(
                () {
                  Get.to(
                    () => const DataScreen(
                      title: 'Privacy Policy',
                      endPoint: 'privacy',
                    ),
                  );
                },
                'Privacy Policy',
                'privacy',
              ),
              _tabCard(
                () {
                  Get.to(
                    () =>
                        const DataScreen(title: 'About Us', endPoint: 'about'),
                  );
                },
                'About Us',
                'about',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tabCard(VoidCallback onTap, String title, String assets) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
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
                    weight: AppTextStyles.regular,
                    color: AppColors.grey[700],
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: AppColors.blue[100]),
        ],
      ),
    );
  }
}
