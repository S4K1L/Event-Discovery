import 'package:flutter/material.dart';
import 'package:flutter_extension/controller/home_controller.dart';
import 'package:flutter_extension/data/model/event_model.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/style.dart';
import 'package:flutter_extension/views/base/custom_bottom_nav.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BookingConfirmation extends StatelessWidget {
  final EventModel event;
  final String email;
  final String totalSeats;
  final String totalPrice;
  BookingConfirmation({
    super.key,
    required this.event,
    required this.email,
    required this.totalSeats,
    required this.totalPrice,
  });
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    String formatted = formatFancyDate(event.date);
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
          'Confirmation',
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
            SvgPicture.asset(
              "assets/icons/confirm_logo.svg",
              height: 200,
              width: 170,
            ),
            const SizedBox(height: 24),
            Text(
              "Booking Confirmed",
              style: AppTextStyles.text20(
                color: AppColors.black,
                weight: AppTextStyles.medium,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          event.title,
                          style: AppTextStyles.text16(
                            color: AppColors.grey[700],
                            weight: AppTextStyles.semibold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.blue[100],
                          borderRadius: BorderRadius.circular(36),
                        ),
                        child: Row(
                          children: [
                            Text(
                              totalSeats,
                              style: AppTextStyles.text18(
                                color: AppColors.grey[800],
                                weight: AppTextStyles.medium,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "seats",
                              style: AppTextStyles.text14(
                                color: AppColors.grey[800],
                                weight: AppTextStyles.medium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formatted,
                        style: AppTextStyles.text14(
                          color: AppColors.grey[500],
                          weight: AppTextStyles.regular,
                        ),
                      ),
                      // const Spacer(),
                      Text(
                        "\$$totalPrice",
                        style: AppTextStyles.text20(
                          color: AppColors.blue[500],
                          weight: AppTextStyles.medium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/location.svg",
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "${event.locationName}, ${event.locationAddress}",
                          style: AppTextStyles.text14(
                            color: AppColors.grey[700],
                            weight: AppTextStyles.regular,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
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
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: InkWell(
            onTap: () => Get.offAll(() => const CustomBottomNavbar()),
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(60),
                border: Border.all(color: AppColors.primary),
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/icons/event.svg",
                    width: 24,
                    height: 24,
                    // ignore: deprecated_member_use
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Explore More Events",
                    style: AppTextStyles.text16(
                      color: AppColors.grey[700],
                      weight: AppTextStyles.regular,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String formatFancyDate(DateTime date) {
    String daySuffix(int day) {
      if (day >= 11 && day <= 13) return 'th';
      switch (day % 10) {
        case 1:
          return 'st';
        case 2:
          return 'nd';
        case 3:
          return 'rd';
        default:
          return 'th';
      }
    }

    final weekday = DateFormat('EEEE').format(date);
    final month = DateFormat('MMMM').format(date);
    final year = DateFormat('y').format(date);
    final day = date.day;

    return '$weekday $day${daySuffix(day)}, $month $year';
  }
}
