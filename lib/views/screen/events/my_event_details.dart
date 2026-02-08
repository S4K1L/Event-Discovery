import 'package:flutter/material.dart';
import 'package:flutter_extension/controller/home_controller.dart';
import 'package:flutter_extension/data/model/event_model.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/style.dart';
import 'package:flutter_extension/views/base/custom_button.dart';
import 'package:flutter_extension/views/screen/events/edit_event.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MyEventDetails extends StatelessWidget {
  final EventModel event;
  MyEventDetails({super.key, required this.event});
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
          'Event Details',
          style: AppTextStyles.text16(
            weight: AppTextStyles.semibold,
            color: AppColors.grey[700],
          ),
        ),
        centerTitle: true,
      ),

      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.blue[100]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Container(
                        height: 220,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: AppColors.blue[50],
                          image: DecorationImage(
                            image: AssetImage(event.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                        width: double.infinity,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                event.formattedDate,
                                style: AppTextStyles.text14(
                                  color: AppColors.grey[500],
                                  weight: AppTextStyles.regular,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                event.timeRange,
                                style: AppTextStyles.text14(
                                  color: AppColors.grey[600],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          Text(
                            event.title,
                            style: AppTextStyles.text20(
                              weight: AppTextStyles.medium,
                              color: AppColors.grey[700],
                            ),
                          ),

                          const SizedBox(height: 12),

                          Text(
                            event.description,
                            style: AppTextStyles.text16(
                              color: AppColors.grey[400],
                              weight: AppTextStyles.regular,
                            ),
                          ),

                          const SizedBox(height: 20),

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
                                    color: AppColors.grey[800],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              Text(
                                "Total Earnings",
                                style: AppTextStyles.text16(
                                  color: AppColors.grey[500],
                                  weight: AppTextStyles.regular,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                "\$${event.totalEarnings!.toStringAsFixed(2)}",
                                style: AppTextStyles.text18(
                                  color: AppColors.primary,
                                  weight: AppTextStyles.medium,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 28),
                          Row(
                            children: [
                              Text(
                                "Seat Sold",
                                style: AppTextStyles.text16(
                                  color: AppColors.grey[500],
                                  weight: AppTextStyles.regular,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.blue[50],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  event.seatText,
                                  style: AppTextStyles.text14(
                                    color: AppColors.grey[800],
                                    weight: AppTextStyles.medium,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 28),
                          Row(
                            children: [
                              Text(
                                "Ticket Price",
                                style: AppTextStyles.text16(
                                  color: AppColors.grey[500],
                                  weight: AppTextStyles.regular,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                "\$${event.price.toStringAsFixed(2)}",
                                style: AppTextStyles.text18(
                                  color: AppColors.primary,
                                  weight: AppTextStyles.medium,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 28),
                          CustomButton(
                            onTap: () {
                              Get.to(() => EditEventScreen(event: event));
                            },
                            text: "Edit Event",
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
