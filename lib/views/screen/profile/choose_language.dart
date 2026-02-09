import 'package:flutter/material.dart';
import 'package:flutter_extension/controller/language_controller.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/style.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ChooseLanguage extends StatelessWidget {
  ChooseLanguage({super.key});

  final LanguageController languageController = Get.find<LanguageController>();

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
          'Choose Language',
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
          child: ListView.separated(
            itemCount: languageController.languages.length,
            separatorBuilder: (_, __) =>
                Divider(height: 1, color: AppColors.blue[100]),
            itemBuilder: (context, index) {
              final language = languageController.languages[index];
              return _languageSelectTab(language);
            },
          ),
        ),
      ),
    );
  }

  Widget _languageSelectTab(String title) {
    return Obx(() {
      final isSelected = languageController.selectedLanguage.value == title;

      return InkWell(
        onTap: () => languageController.changeLanguage(title),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Row(
            children: [
              Text(
                title,
                style: AppTextStyles.text16(
                  weight: AppTextStyles.regular,
                  color: AppColors.grey[700],
                ),
              ),
              const Spacer(),
              if (isSelected)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : Colors.transparent,
                    borderRadius: BorderRadius.circular(60),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.grey[300]!,
                      width: 2,
                    ),
                  ),
                  child: isSelected
                      ? Padding(
                          padding: const EdgeInsets.all(2),
                          child: SvgPicture.asset(
                            'assets/icons/sign.svg',
                            width: 12,
                            height: 12,
                            color: AppColors.white,
                          ),
                        )
                      : null,
                ),
            ],
          ),
        ),
      );
    });
  }
}
