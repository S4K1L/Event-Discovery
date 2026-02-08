import 'package:flutter/material.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/style.dart';
import 'package:flutter_extension/views/base/custom_button.dart';
import 'package:flutter_svg/svg.dart';

class PaypalLoginDialog extends StatefulWidget {
  const PaypalLoginDialog({super.key});

  @override
  State<PaypalLoginDialog> createState() => _PaypalLoginDialogState();
}

class _PaypalLoginDialogState extends State<PaypalLoginDialog> {
  final TextEditingController _emailController = TextEditingController();

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
            SvgPicture.asset('assets/icons/paypal.svg', height: 40),
            const SizedBox(height: 20),

            const Text(
              "Pay with Paypal",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),

            const Text(
              "Enter your email address to get started",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 22),

            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: "Email or mobile number",
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFCCCCCC)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF0070BA)),
                ),
              ),
            ),

            const SizedBox(height: 10),

            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(50, 30),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  "Forgot email?",
                  style: AppTextStyles.text14(
                    color: AppColors.primary,
                    weight: AppTextStyles.semibold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),

            CustomButton(
              onTap: () {
                final email = _emailController.text.trim();
                Navigator.pop(context, email);
              },
              text: "Next",
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
