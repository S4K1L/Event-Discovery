import 'package:flutter/material.dart';
import 'package:flutter_extension/controller/auth_controller.dart';
import 'package:flutter_extension/data/model/user_model.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/style.dart';
import 'package:flutter_extension/views/base/custom_text_field.dart';
import 'package:flutter_extension/views/base/small_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ProfileInformation extends StatefulWidget {
  final UserModel user;
  const ProfileInformation({super.key, required this.user});

  @override
  State<ProfileInformation> createState() => _ProfileInformationState();
}

class _ProfileInformationState extends State<ProfileInformation> {
  final AuthController authController = Get.find<AuthController>();
  late TextEditingController nameController = TextEditingController();
  late TextEditingController emailController = TextEditingController();

  bool isFormValid = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.name);
    emailController = TextEditingController(text: widget.user.email);
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

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
          'Profile Information',
          style: AppTextStyles.text16(
            weight: AppTextStyles.semibold,
            color: AppColors.grey[700],
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 24),
                SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: AppColors.primary,
                        child: const CircleAvatar(
                          radius: 58,
                          backgroundImage: AssetImage(
                            "assets/images/profile.png",
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        left: 0,
                        bottom: 0,
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: AppColors.white,
                          child: CircleAvatar(
                            radius: 16,
                            backgroundColor: AppColors.primary,
                            child: SvgPicture.asset(
                              'assets/icons/edit.svg',
                              height: 16,
                              width: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  label: 'Your Nane',
                  hint: 'Enter your password',
                  controller: nameController,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Email',
                  hint: 'Enter your email',
                  controller: emailController,
                  isEmail: true,
                  readOnly: true,
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmallButtons(
                      onTap: () => Get.back(),
                      text: 'Cancel',
                      hasFillColor: false,
                    ),
                    SmallButtons(onTap: () {}, text: 'Save Changes'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
