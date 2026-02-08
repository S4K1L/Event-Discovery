import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/style.dart';
import 'package:flutter_extension/views/base/custom_bottom_nav.dart';
import 'package:flutter_extension/views/base/custom_button.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class DocumentLoading extends StatefulWidget {
  final String title;
  final String subTitle;

  const DocumentLoading({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  State<DocumentLoading> createState() => _DocumentLoadingState();
}

class _DocumentLoadingState extends State<DocumentLoading> {
  PlatformFile? passport, residencePermit, paypalEmail;

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
          'Under Review',
          style: AppTextStyles.text16(
            weight: AppTextStyles.semibold,
            color: AppColors.grey[700],
          ),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              "assets/lottie/loading.json",
              height: 100,
              width: 100,
              repeat: true,
            ),

            const SizedBox(height: 32),
            Text(
              widget.title,
              style: AppTextStyles.text20(
                weight: AppTextStyles.medium,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.subTitle,
              style: AppTextStyles.text14(
                weight: AppTextStyles.regular,
                color: AppColors.grey[400],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            CustomButton(
              onTap: () {
                Get.offAll(() => const CustomBottomNavbar());
              },
              text: "Back to Homepage",
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
