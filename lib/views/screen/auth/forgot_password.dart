import 'package:flutter/material.dart';
import 'package:flutter_extension/controller/auth_controller.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/style.dart';
import 'package:flutter_extension/views/base/custom_button.dart';
import 'package:flutter_extension/views/base/custom_text_field.dart';
import 'package:flutter_extension/views/screen/auth/otp_screen.dart';
import 'package:get/get.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final AuthController authController = Get.find<AuthController>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isFormValid = false;

  @override
  void initState() {
    super.initState();
    emailController.addListener(_validateForm);
    passwordController.addListener(_validateForm);
  }

  void _validateForm() {
    final email = emailController.text.trim();

    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');

    final valid = emailRegex.hasMatch(email);

    if (valid != isFormValid) {
      setState(() {
        isFormValid = valid;
      });
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
                  "Forgot password",
                  style: AppTextStyles.display24(
                    color: AppColors.grey[900],
                    weight: AppTextStyles.semibold,
                  ),
                ),

                Text(
                  "Enter your email to reset your password",
                  style: AppTextStyles.text16(
                    color: AppColors.grey[400],
                    weight: AppTextStyles.regular,
                  ),
                ),

                const SizedBox(height: 24),

                CustomTextField(
                  label: 'Email',
                  hint: 'Enter your email',
                  isEmail: true,
                  controller: emailController,
                ),

                const SizedBox(height: 24),

                CustomButton(
                  onTap: () {
                    if (isFormValid) {
                      // Perform registration logic here
                      Get.to(
                        () => OtpScreen(
                          email: emailController.text,
                          title: "verification",
                          isForResetPassword: true,
                        ),
                      );
                    } else {
                      Get.snackbar(
                        "Error",
                        "Please enter a valid email address.",
                        backgroundColor: AppColors.red[500]!,
                        colorText: AppColors.white,
                      );
                    }
                  },
                  text: "Send OTP",
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
