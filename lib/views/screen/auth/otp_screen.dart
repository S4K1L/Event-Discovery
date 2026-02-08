import 'package:flutter/material.dart';
import 'package:flutter_extension/controller/auth_controller.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/style.dart';
import 'package:flutter_extension/views/base/custom_border_button.dart';
import 'package:flutter_extension/views/base/custom_bottom_nav.dart';
import 'package:flutter_extension/views/base/custom_button.dart';
import 'package:flutter_extension/views/base/otp_field.dart';
import 'package:flutter_extension/views/screen/auth/reset_password.dart';
import 'package:get/get.dart';

class OtpScreen extends StatefulWidget {
  final String title;
  final String email;
  final bool isForResetPassword;
  const OtpScreen({
    super.key,
    required this.email,
    required this.title,
    this.isForResetPassword = false,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final AuthController authController = Get.find<AuthController>();
  String currentOtp = "";
  bool isFormValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Enter ${widget.title} code",
                style: AppTextStyles.text18(
                  color: AppColors.grey[900],
                  weight: AppTextStyles.semibold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "A 4-digit code was sent to\n${widget.email}",
                style: AppTextStyles.text14(
                  color: AppColors.grey[700],
                  weight: AppTextStyles.regular,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  Obx(
                    () => OtpInput(
                      length: 4,
                      hasError: authController.otpError.value,
                      errorText:
                          "Your OTP is incorrect. Please try\nagain later.",
                      onCompleted: (otp) {
                        setState(() {
                          currentOtp = otp;
                          isFormValid = otp.length == 4;
                        });

                        authController
                            .clearOtpError(); // reset red border when user types again
                      },
                    ),
                  ),
                  const SizedBox(),
                ],
              ),
              const SizedBox(height: 32),
              Text(
                "Haven’t received code yet?",
                style: AppTextStyles.text12(
                  color: AppColors.grey[400],
                  weight: AppTextStyles.regular,
                ),
              ),
              const SizedBox(height: 16),
              CustomBorderButton(title: "Resend Code", onTap: () {}),

              const SizedBox(height: 100),
              CustomButton(
                text: "Continue",
                onTap: () async {
                  if (!isFormValid) {
                    Get.snackbar(
                      "Error",
                      "Please enter the 4-digit OTP sent to your email.",
                      backgroundColor: AppColors.red[500]!,
                      colorText: AppColors.white,
                    );
                    return;
                  }

                  if (widget.isForResetPassword) {
                    Get.to(() => const ResetPassword());
                  } else {
                    Get.offAll(() => const CustomBottomNavbar());
                  }

                  bool success = authController.verifyOtp(currentOtp);

                  if (!success) {
                    authController.setOtpError(true);
                  }
                },
                color: isFormValid
                    ? AppColors.primary
                    : AppColors.primary.withOpacity(0.3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
