import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_extension/controller/home_controller.dart';
import 'package:flutter_extension/data/model/event_model.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/style.dart';
import 'package:flutter_extension/views/screen/common/notification.dart';
import 'package:flutter_extension/views/screen/home/event_details.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Get.put(HomeController());

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
            child: Column(
              children: [_searchBar(), const SizedBox(height: 24), _filter()],
            ),
          ),

          const SizedBox(height: 24),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                itemCount: homeController.dummyEvents.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  final event = homeController.dummyEvents[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _eventCard(event: event),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector _eventCard({required EventModel event}) {
    return GestureDetector(
      onTap: () => Get.to(() => EventDetails(event: event)),
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

  Row _filter() {
    return Row(
      children: [
        GestureDetector(
          onTapDown: (details) =>
              _showLocationMenu(context, details.globalPosition),
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/icons/location.svg",
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 8),
              Obx(
                () => Text(
                  homeController.selectedLocation.value,
                  style: AppTextStyles.text16(
                    color: AppColors.primary,
                    weight: AppTextStyles.medium,
                  ),
                ),
              ),
              SvgPicture.asset(
                "assets/icons/down_arrow.svg",
                width: 24,
                height: 24,
              ),
            ],
          ),
        ),

        const Spacer(),
        GestureDetector(
          onTapDown: (details) =>
              _showTimeMenu(context, details.globalPosition),
          child: Container(
            height: 35,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.primary,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset("assets/icons/filter.svg", width: 16),
                const SizedBox(width: 4),
                Obx(
                  () => Text(
                    homeController.selectedTimeFilter.value,
                    style: AppTextStyles.text16(
                      color: AppColors.white,
                      weight: AppTextStyles.regular,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Container _searchBar() {
    return Container(
      height: 48,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(66),
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
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12),
                  child: SvgPicture.asset(
                    "assets/icons/search.svg",
                    width: 22,
                    height: 22,
                  ),
                ),
                hintText: "Search events...",
                hintStyle: AppTextStyles.text14(
                  color: AppColors.grey[400]!,
                  weight: AppTextStyles.regular,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
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
            const CircleAvatar(
              radius: 22,
              backgroundImage: AssetImage("assets/images/profile.png"),
            ),
            const SizedBox(width: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hi, Susan",
                  style: AppTextStyles.text18(
                    color: Colors.white,
                    weight: AppTextStyles.medium,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "Ready for your next outing?",
                  style: AppTextStyles.text14(
                    color: Colors.white,
                    weight: AppTextStyles.regular,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
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

  //helpers
  void _showLocationMenu(BuildContext context, Offset position) {
    final locations = ["All", "Zürich", "Geneva", "Basel", "Bern", "Lausanne"];

    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.2),
      builder: (_) => _buildAnchoredPopup(
        position: position,
        alignLeft: true,
        items: locations,
        selectedValue: homeController.selectedLocation.value,
        onSelect: homeController.setLocation,
      ),
    );
  }

  void _showTimeMenu(BuildContext context, Offset position) {
    final filters = [
      "3 Days",
      "This Week",
      "15 Days",
      "This Month",
      "This Year",
    ];

    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.2),
      builder: (_) => _buildAnchoredPopup(
        position: position,
        alignLeft: false,
        items: filters,
        selectedValue: homeController.selectedTimeFilter.value,
        onSelect: homeController.setTimeFilter,
      ),
    );
  }

  Widget _buildAnchoredPopup({
    required Offset position,
    required bool alignLeft,
    required List<String> items,
    required String selectedValue,
    required Function(String) onSelect,
  }) {
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: GestureDetector(
            onTap: () => Navigator.pop(Get.context!),
            child: Container(color: Colors.transparent),
          ),
        ),
        Positioned(
          top: position.dy + 10,
          left: alignLeft ? position.dx - 20 : null,
          right: alignLeft ? null : 20,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 200,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: items.map((item) {
                  final isActive = item == selectedValue;
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          onSelect(item);
                          Navigator.pop(Get.context!);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          alignment: Alignment.center,
                          child: Text(
                            item,
                            style: AppTextStyles.text14(
                              color: isActive
                                  ? AppColors.primary
                                  : AppColors.grey[900],
                              weight: isActive
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      if (item != items.last)
                        Container(height: 1, color: AppColors.grey[200]),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
