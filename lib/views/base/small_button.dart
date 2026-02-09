import 'package:flutter/material.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/style.dart';

class SmallButtons extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final double? width;
  final double? height;
  final bool? hasFillColor;
  const SmallButtons({
    super.key,
    required this.onTap,
    required this.text,
    this.hasFillColor = true,
    this.width = 170,
    this.height = 48,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: hasFillColor == true ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(45),
          border: Border.all(
            color: hasFillColor == true
                ? Colors.transparent
                : AppColors.primary,
            width: 1.5,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: AppTextStyles.text14(
              color: hasFillColor == true ? AppColors.white : AppColors.primary,
              weight: AppTextStyles.semibold,
            ),
          ),
        ),
      ),
    );
  }
}
