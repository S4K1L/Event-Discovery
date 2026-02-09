import 'package:flutter/material.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/style.dart';
import 'package:flutter_extension/views/base/custom_bottom_nav.dart';
import 'package:flutter_extension/views/base/custom_button.dart';
import 'package:flutter_extension/views/base/custom_password_field.dart';
import 'package:flutter_extension/views/base/custom_text_field.dart';
import 'package:flutter_extension/views/screen/auth/forgot_password.dart';
import 'package:flutter_extension/views/screen/auth/signup.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
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

      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    "assets/images/splash3.png",
                    width: 250,
                    height: 100,
                  ),
                ),
                const SizedBox(height: 100),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome!",
                        style: AppTextStyles.display24(
                          color: AppColors.grey[900],
                          weight: AppTextStyles.semibold,
                        ),
                      ),
                      const SizedBox(height: 24),

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

                      // const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          Get.to(() => const ForgotPassword());
                        },
                        child: Text(
                          "Forgot password?",
                          style: AppTextStyles.text14(
                            color: AppColors.blue[500],
                            weight: FontWeight.w500,
                          ),
                        ),
                      ),

                      // const SizedBox(height: 24),
                      CustomButton(
                        onTap: () {
                          // if (isFormValid) {

                          // }
                          Get.offAll(() => const CustomBottomNavbar());
                        },
                        text: "Login",
                        color: isFormValid
                            ? AppColors.primary
                            : AppColors.primary.withValues(alpha: .3),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Not a member?",
                            style: AppTextStyles.text14(
                              color: AppColors.grey[400],
                              weight: FontWeight.w600,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.to(() => const SignUpScreen());
                            },
                            child: Text(
                              "Register now",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
