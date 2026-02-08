import 'package:flutter/material.dart';
import 'package:flutter_extension/controller/home_controller.dart';
import 'package:flutter_extension/data/model/event_model.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/style.dart';
import 'package:flutter_extension/views/base/custom_button.dart';
import 'package:flutter_extension/views/base/paypal_popup.dart';
import 'package:flutter_extension/views/screen/home/booking_confirmation.dart';
import 'package:get/get.dart';

class BookEvent extends StatelessWidget {
  final EventModel event;
  BookEvent({super.key, required this.event});
  final HomeController homeController = Get.find<HomeController>();

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
          'Book Event',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select number of seats",
              style: AppTextStyles.text20(
                color: AppColors.grey[700],
                weight: AppTextStyles.medium,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _counterButton(false, onTap: () => homeController.decrement()),
                const SizedBox(width: 20),
                Obx(
                  () => Text(
                    homeController.value.toString(),
                    style: AppTextStyles.display30(
                      weight: AppTextStyles.medium,
                      color: AppColors.grey[700],
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                _counterButton(true, onTap: () => homeController.increment()),
              ],
            ),
            const SizedBox(height: 32),
            Obx(
              () => Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${homeController.value} tickets × \$${event.price} =",
                      style: AppTextStyles.text16(
                        color: AppColors.grey[400],
                        weight: AppTextStyles.regular,
                      ),
                    ),
                    Text(
                      "\$${homeController.value * event.price}",
                      style: AppTextStyles.display36(
                        color: AppColors.blue[500],
                        weight: AppTextStyles.medium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Obx(
            () => CustomButton(
              onTap: homeController.value > 0
                  ? () => openPaypalDialog(context)
                  : () {},
              text: "Confirm",
              color: homeController.value > 0 ? AppColors.primary : null,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> openPaypalDialog(BuildContext context) async {
    final result = await showDialog<String>(
      context: context,
      builder: (_) => const PaypalLoginDialog(),
    );

    if (result != null && result.isNotEmpty) {
      Get.to(
        () => BookingConfirmation(
          event: event,
          email: result,
          totalSeats: homeController.value.toString(),
          totalPrice: (homeController.value * event.price).toStringAsFixed(2),
        ),
      );
    }
  }

  InkWell _counterButton(bool isIncrement, {Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 52,
        decoration: BoxDecoration(
          color: AppColors.blue[100]!,
          borderRadius: BorderRadius.only(
            topLeft: isIncrement
                ? const Radius.circular(0)
                : const Radius.circular(8),
            bottomLeft: isIncrement
                ? const Radius.circular(0)
                : const Radius.circular(8),
            topRight: isIncrement
                ? const Radius.circular(8)
                : const Radius.circular(0),
            bottomRight: isIncrement
                ? const Radius.circular(8)
                : const Radius.circular(0),
          ),
          border: Border.all(color: AppColors.blue[500]!),
        ),
        child: Icon(
          isIncrement ? Icons.add : Icons.remove,
          size: 28,
          color: AppColors.blue[500]!,
        ),
      ),
    );
  }
}
