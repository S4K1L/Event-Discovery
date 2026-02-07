import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_extension/controller/auth_controller.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/style.dart';
import 'package:flutter_extension/views/base/custom_button.dart';
import 'package:flutter_extension/views/base/custom_password_field.dart';
import 'package:flutter_extension/views/base/custom_text_field.dart';
import 'package:flutter_extension/views/screen/auth/login.dart';
import 'package:flutter_extension/views/screen/auth/otp_screen.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
    final password = passwordController.text.trim();

    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');

    final valid = emailRegex.hasMatch(email) && password.length >= 6;

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
                Text(
                  "Sign up",
                  style: AppTextStyles.display24(
                    color: AppColors.gray[900],
                    weight: AppTextStyles.semibold,
                  ),
                ),

                Text(
                  "Create an account to get started ",
                  style: AppTextStyles.text16(
                    color: AppColors.gray[400],
                    weight: AppTextStyles.regular,
                  ),
                ),

                const SizedBox(height: 24),

                CustomTextField(
                  label: 'Name',
                  hint: 'Enter your name',
                  isEmail: false,
                  controller: nameController,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  label: 'Email',
                  hint: 'Enter your email',
                  isEmail: true,
                  controller: emailController,
                ),
                const SizedBox(height: 16),

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

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => Checkbox(
                        value: authController.checkBox.value,
                        onChanged: (_) => authController.toggleCheckbox(),
                        activeColor: AppColors.primary,
                        checkColor: AppColors.white,
                        side: BorderSide(
                          color: AppColors.gray[300]!,
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: AppTextStyles.text14(
                            color: AppColors.gray[500],
                            weight: FontWeight.w500,
                          ),
                          children: [
                            const TextSpan(
                              text: "I've read and agree with the ",
                            ),
                            TextSpan(
                              text: "Terms and Conditions",
                              style: AppTextStyles.text14(
                                color: AppColors.primary,
                                weight: FontWeight.w600,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // open terms screen
                                },
                            ),
                            const TextSpan(text: " and the "),
                            TextSpan(
                              text: "Privacy Policy.",
                              style: AppTextStyles.text14(
                                color: AppColors.primary,
                                weight: FontWeight.w600,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // open privacy screen
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                CustomButton(
                  onTap: () {
                    if (isFormValid && authController.checkBox.value) {
                      // Perform registration logic here
                      Get.to(
                        () => OtpScreen(
                          email: emailController.text,
                          title: "confirmation",
                        ),
                      );
                    } else {
                      Get.snackbar(
                        "Error",
                        "Please fill all fields correctly and accept the terms.",
                        backgroundColor: AppColors.red[500]!,
                        colorText: AppColors.white,
                      );
                    }
                  },
                  text: "Register",
                  color: isFormValid
                      ? AppColors.primary
                      : AppColors.primary.withValues(alpha: .3),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: AppTextStyles.text14(
                        color: AppColors.gray[400],
                        weight: FontWeight.w600,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() => const LoginScreen());
                      },
                      child: Text(
                        "Login",
                        style: AppTextStyles.text14(
                          color: AppColors.primary,
                          weight: FontWeight.w600,
                        ),
                      ),
                    ),
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
