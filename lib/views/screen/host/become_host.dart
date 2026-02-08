import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/style.dart';
import 'package:flutter_extension/views/base/custom_button.dart';
import 'package:flutter_extension/views/base/upload_form.dart';
import 'package:flutter_extension/views/screen/common/document_loading.dart';
import 'package:get/get.dart';

class BecomeHost extends StatefulWidget {
  const BecomeHost({super.key});

  @override
  State<BecomeHost> createState() => _BecomeHostState();
}

class _BecomeHostState extends State<BecomeHost> {
  PlatformFile? passport, residencePermit, paypalEmail;

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
          'Become Host',
          style: AppTextStyles.text16(
            weight: AppTextStyles.semibold,
            color: AppColors.grey[700],
          ),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Upload these document to become a host",
              style: AppTextStyles.text16(
                color: AppColors.grey[700],
                weight: AppTextStyles.regular,
              ),
            ),
            const SizedBox(height: 32),

            UploadInputField(
              hintText: "Passport / Driving License",
              onFileSelected: (file) {
                setState(() {
                  passport = file;
                });
              },
            ),

            const SizedBox(height: 12),
            UploadInputField(
              hintText: "Residence permit",
              onFileSelected: (file) {
                setState(() {
                  residencePermit = file;
                });
              },
            ),

            const SizedBox(height: 12),
            UploadInputField(
              hintText: "Paypal email",
              onFileSelected: (file) {
                setState(() {
                  paypalEmail = file;
                });
              },
            ),

            const SizedBox(height: 32),
            CustomButton(
              onTap: () {
                Get.to(
                  () => const DocumentLoading(
                    title: "Your Documents Are Under Review",
                    subTitle:
                        "Thank you for submitting your documents! Our team is reviewing your documents",
                  ),
                );
              },
              text: "Submit",
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
