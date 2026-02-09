import 'package:flutter/material.dart';
import 'package:flutter_extension/controller/events_controller.dart';
import 'package:flutter_extension/data/model/event_model.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/style.dart';
import 'package:get/get.dart';

class BookingHistory extends StatefulWidget {
  const BookingHistory({super.key});

  @override
  State<BookingHistory> createState() => _BookingHistoryState();
}

class _BookingHistoryState extends State<BookingHistory> {
  final EventsController eventsController = Get.put(EventsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.blue[50],
        elevation: 0,
        leading: IconButton(
          onPressed: Get.back,
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 18,
            color: AppColors.grey[600],
          ),
        ),
        title: Text(
          'Booking History',
          style: AppTextStyles.text16(
            weight: AppTextStyles.semibold,
            color: AppColors.grey[700],
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _filterButton(
                    EventHistoryTab.upcomingEvent,
                    "Upcoming Event",
                  ),
                  _filterButton(EventHistoryTab.pastEvent, "Past Event"),
                ],
              ),
              const SizedBox(height: 24),

              /// EVENT LIST
              Expanded(
                child: Obx(() {
                  final events = eventsController.historyEvents;
                  final selectedTab = eventsController.historySelectedTab.value;

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
                            itemBuilder: (context, index) {
                              final event = events[index];

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: _eventCard(
                                  event: event,
                                  isMyEvent: selectedTab == EventTab.myEvent,
                                  isAttending:
                                      selectedTab == EventTab.attending,
                                ),
                              );
                            },
                          ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// FILTER TAB BUTTON
  Widget _filterButton(EventHistoryTab tab, String title) {
    return Obx(() {
      final isActive = eventsController.historySelectedTab.value == tab;

      return InkWell(
        onTap: () => eventsController.changeHistoryTab(tab),
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
              width: MediaQuery.of(context).size.width * 0.45,
              color: isActive ? AppColors.primary : Colors.transparent,
            ),
          ],
        ),
      );
    });
  }

  /// EVENT CARD
  Widget _eventCard({
    required EventModel event,
    bool isMyEvent = false,
    bool isAttending = false,
  }) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            /// EVENT IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                event.imageUrl,
                width: 90,
                height: 90,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 90,
                  height: 90,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image_not_supported),
                ),
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// TITLE
                  Text(
                    event.title,
                    style: AppTextStyles.text16(
                      weight: AppTextStyles.semibold,
                      color: AppColors.grey[900],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  /// LOCATION ROW
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          event.locationAddress,
                          style: AppTextStyles.text14(
                            color: AppColors.grey[600],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  /// START TIME
                  Row(
                    children: [
                      Text(
                        "Starts : ",
                        style: AppTextStyles.text14(color: AppColors.grey[600]),
                      ),
                      Text(
                        event.endTime,
                        style: AppTextStyles.text14(
                          weight: AppTextStyles.medium,
                          color: AppColors.grey[800],
                        ),
                      ),
                    ],
                  ),

                  /// DURATION
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Host By : ",
                            style: AppTextStyles.text14(
                              color: AppColors.grey[600],
                            ),
                          ),
                          Text(
                            event.organizerName, // e.g. "3 Hour"
                            style: AppTextStyles.text14(
                              weight: AppTextStyles.medium,
                              color: AppColors.grey[800],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.blue[50],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          event.seatText,
                          style: AppTextStyles.text14(
                            color: AppColors.primary,
                            weight: AppTextStyles.semibold,
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
    );
  }
}
