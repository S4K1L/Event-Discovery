import 'package:flutter/material.dart';
import 'package:flutter_extension/controller/auth_controller.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/style.dart';
import 'package:flutter_extension/views/base/custom_button.dart';
import 'package:flutter_extension/views/base/custom_password_field.dart';
import 'package:flutter_extension/views/screen/auth/login.dart';
import 'package:get/get.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final AuthController authController = Get.find<AuthController>();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isFormValid = false;

  @override
  void initState() {
    super.initState();
    passwordController.addListener(_validateForm);
  }

  void _validateForm() {
    final password = passwordController.text.trim();

    final confirmPassword = confirmPasswordController.text.trim();

    final valid = password.length >= 6 && password == confirmPassword;
    if (valid != isFormValid) {
      setState(() {
        isFormValid = valid;
      });
    }
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Text(
                  "Reset Password",
                  style: AppTextStyles.display24(
                    color: AppColors.gray[900],
                    weight: AppTextStyles.semibold,
                  ),
                ),
                const SizedBox(height: 24),
                CustomPasswordField(
                  label: 'Password',
                  hint: 'Enter your password',
                  controller: passwordController,
                ),
                const SizedBox(height: 16),
                CustomPasswordField(
                  label: 'Confirm Password',
                  hint: 'Enter your password again',
                  controller: confirmPasswordController,
                ),
                const SizedBox(height: 24),

                CustomButton(
                  onTap: () {
                    if (isFormValid) {
                      Get.to(() => const LoginScreen());
                    } else {
                      Get.snackbar(
                        "Error",
                        "Please enter a valid password and make sure both fields match.",
                        backgroundColor: AppColors.red[500]!,
                        colorText: AppColors.white,
                      );
                    }
                  },
                  text: "Continue",
                  color: isFormValid
                      ? AppColors.primary
                      : AppColors.primary.withValues(alpha: .3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
