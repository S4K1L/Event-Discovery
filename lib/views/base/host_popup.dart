import 'package:flutter/material.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/style.dart';
import 'package:flutter_extension/views/base/custom_button.dart';
import 'package:flutter_extension/views/screen/host/become_host.dart';
import 'package:get/get.dart';

class HostDialog extends StatefulWidget {
  const HostDialog({super.key});

  @override
  State<HostDialog> createState() => _HostDialogState();
}

class _HostDialogState extends State<HostDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 50),
            Text(
              "Only hosts can create event",
              style: AppTextStyles.text20(
                weight: AppTextStyles.medium,
                color: AppColors.grey[700],
              ),
            ),

            const SizedBox(height: 18),

            CustomButton(
              onTap: () {
                Get.to(() => BecomeHost());
              },
              text: "Become Hosts",
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
