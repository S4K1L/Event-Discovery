import 'package:flutter/material.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/style.dart';
import 'package:flutter_extension/views/base/small_button.dart';
import 'package:get/get.dart';

void showLogoutBottomSheet(
  BuildContext context,
  VoidCallback onConfirm,
  String message,
  String title,
  String confirmTitle,
) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) {
      return Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            Text(
              title,
              style: AppTextStyles.text18(
                weight: AppTextStyles.semibold,
                color: AppColors.red[500],
              ),
            ),

            const SizedBox(height: 12),
            Divider(color: AppColors.blue[100], height: 1),
            const SizedBox(height: 20),

            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.text18(
                color: AppColors.grey[500],
                weight: AppTextStyles.medium,
              ),
            ),

            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmallButtons(
                  onTap: onConfirm,
                  text: "Yes, Logout",
                  hasFillColor: false,
                ),
                SmallButtons(onTap: () => Get.back(), text: "Cancel"),
              ],
            ),
          ],
        ),
      );
    },
  );
}
