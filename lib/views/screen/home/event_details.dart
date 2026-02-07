import 'package:flutter/material.dart';
import 'package:flutter_extension/data/model/event_model.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class EventDetails extends StatelessWidget {
  final EventModel event;
  const EventDetails({super.key, required this.event});

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
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: Image.asset(
                        event.imageUrl,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
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
                              const Spacer(),
                              SvgPicture.asset(
                                "assets/icons/bookmark.svg",
                                width: 24,
                                height: 24,
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
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
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
                              const Spacer(),
                              Text(
                                "Party by: ${event.organizerName}",
                                style: AppTextStyles.text14(
                                  color: AppColors.grey[700],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/icons/location.svg",
                                width: 18,
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(color: AppColors.background),
            child: Row(
              children: [
                Text(
                  "\$${event.price.toStringAsFixed(2)}",
                  style: AppTextStyles.text20(
                    color: AppColors.primary,
                    weight: AppTextStyles.semibold,
                  ),
                ),
                const Spacer(),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text("Join event"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 14,
                    ),
                    side: BorderSide(color: AppColors.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
