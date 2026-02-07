import 'package:flutter/material.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/style.dart';

class CustomBorderButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const CustomBorderButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary, width: 1.5),
          borderRadius: BorderRadius.circular(45),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 14),
          child: Text(
            title,
            style: AppTextStyles.text14(
              color: AppColors.primary,
              weight: AppTextStyles.semibold,
            ),
          ),
        ),
      ),
    );
  }
}
