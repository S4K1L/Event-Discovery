// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_extension/controller/events_controller.dart';
import 'package:flutter_extension/data/model/event_model.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/style.dart';
import 'package:flutter_extension/views/screen/common/notification.dart';
import 'package:flutter_extension/views/screen/events/my_event_details.dart';
import 'package:flutter_extension/views/screen/home/event_details.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class EventsScreens extends StatefulWidget {
  const EventsScreens({super.key});

  @override
  State<EventsScreens> createState() => _EventsScreensState();
}

class _EventsScreensState extends State<EventsScreens> {
  final EventsController eventsController = Get.put(EventsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _appBar(),
          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _filterButton(EventTab.myEvent, "My Event"),
                _filterButton(EventTab.attending, "Attending"),
                _filterButton(EventTab.saved, "Saved"),
              ],
            ),
          ),

          const SizedBox(height: 24),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Obx(() {
                final events = eventsController.currentEvents;

                return RefreshIndicator(
                  color: AppColors.primary,
                  onRefresh: eventsController.refreshCurrentTab,
                  child: events.isEmpty
                      ? ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: const [
                            SizedBox(height: 200),
                            Center(child: Text("No events found")),
                          ],
                        )
                      : ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: events.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            final event = events[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: _eventCard(
                                event: event,
                                isMyEvent:
                                    eventsController.selectedTab.value ==
                                        EventTab.myEvent
                                    ? true
                                    : false,
                                isAttending:
                                    eventsController.selectedTab.value ==
                                        EventTab.attending
                                    ? true
                                    : false,
                              ),
                            );
                          },
                        ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterButton(EventTab tab, String title) {
    return Obx(() {
      final isActive = eventsController.selectedTab.value == tab;

      return InkWell(
        onTap: () => eventsController.changeTab(tab),
        child: Column(
          children: [
            Text(
              title,
              style: AppTextStyles.text16(
                color: isActive ? AppColors.primary : AppColors.grey[400],
                weight: AppTextStyles.medium,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              height: 2,
              width: 80,
              color: isActive ? AppColors.primary : Colors.transparent,
            ),
          ],
        ),
      );
    });
  }

  GestureDetector _eventCard({
    required EventModel event,
    bool isMyEvent = false,
    bool isAttending = false,
  }) {
    return GestureDetector(
      onTap: () {
        if (isMyEvent) {
          Get.to(() => MyEventDetails(event: event));
        } else {
          Get.to(() => EventDetails(event: event, isAttending: isAttending));
        }
      },
      child: Container(
        height: 110,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  event.imageUrl,
                  width: 100,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            /// TEXT AREA
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 12, top: 12, bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// TITLE + SEATS BADGE
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            event.title,
                            style: AppTextStyles.text16(
                              color: AppColors.grey[900],
                              weight: AppTextStyles.medium,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.blue[50],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            event.seatText,
                            style: AppTextStyles.text12(
                              color: AppColors.blue[600],
                              weight: AppTextStyles.medium,
                            ),
                          ),
                        ),
                      ],
                    ),

                    /// DATE + PRICE
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          event.formattedDate,
                          style: AppTextStyles.text14(
                            color: AppColors.grey[600],
                            weight: AppTextStyles.regular,
                          ),
                        ),
                        Text(
                          "\$${event.price}",
                          style: AppTextStyles.text16(
                            color: AppColors.primary,
                            weight: AppTextStyles.semibold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _appBar() {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        color: AppColors.primary,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/splash3.png",
              width: 120,
              height: 48,
              color: AppColors.white,
            ),
            const Spacer(),
            InkWell(
              onTap: () => Get.to(
                () => NotificationScreen(),
                transition: Transition.rightToLeft,
              ),
              child: SvgPicture.asset(
                "assets/icons/notification.svg",
                width: 24,
                height: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
