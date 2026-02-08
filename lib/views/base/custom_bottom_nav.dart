import 'package:flutter/material.dart';
import 'package:flutter_extension/controller/home_controller.dart';
import 'package:flutter_extension/views/base/host_popup.dart';
import 'package:flutter_extension/views/screen/events/create_events.dart';
import 'package:flutter_extension/views/screen/events/events_screen.dart';
import 'package:flutter_extension/views/screen/home/home_screen.dart';
import 'package:flutter_extension/views/screen/message/message_screen.dart';
import 'package:flutter_extension/views/screen/profile/profile.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/style.dart';
import 'package:get/get.dart';

class CustomBottomNavbar extends StatefulWidget {
  const CustomBottomNavbar({super.key});

  @override
  State<CustomBottomNavbar> createState() => _CustomBottomNavbarState();
}

class _CustomBottomNavbarState extends State<CustomBottomNavbar> {
  final HomeController homeController = Get.find<HomeController>();
  int currentIndex = 0;

  final List<Widget> pages = [
    const HomeScreen(),
    const EventsScreens(),
    const MessageScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: pages[currentIndex],
      bottomNavigationBar: CustomBottomUi(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() => currentIndex = index);
        },
        onCenterTap: () {
          if (homeController.isHost.value) {
            Get.to(() => const CreateEventScreen());
          } else {
            openHostDialog(context);
          }
        },
      ),
    );
  }

  Future<void> openHostDialog(BuildContext context) async {
    final result = await showDialog<String>(
      context: context,
      builder: (_) => const HostDialog(),
    );

    if (result != null && result.isNotEmpty) {}
  }
}

class CustomBottomUi extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final VoidCallback onCenterTap;

  const CustomBottomUi({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.onCenterTap,
  });

  Widget _navItem({
    required String iconPath,
    required String label,
    required bool isActive,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 4,
            width: 48,
            decoration: BoxDecoration(
              color: isActive ? AppColors.primary : Colors.transparent,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(2),
                bottomRight: Radius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 14),
          SvgPicture.asset(
            iconPath,
            height: 32,
            width: 32,
            colorFilter: ColorFilter.mode(
              isActive ? AppColors.primary : AppColors.grey[400]!,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTextStyles.text12(
              color: isActive ? AppColors.primary : AppColors.grey[400],
              weight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _navItem(
                  iconPath: 'assets/icons/home.svg',
                  label: "Home",
                  isActive: currentIndex == 0,
                  onPressed: () => onTap(0),
                ),
                _navItem(
                  iconPath: 'assets/icons/event.svg',
                  label: "Events",
                  isActive: currentIndex == 1,
                  onPressed: () => onTap(1),
                ),
                const SizedBox(width: 40),
                _navItem(
                  iconPath: 'assets/icons/message.svg',
                  label: "Messages",
                  isActive: currentIndex == 2,
                  onPressed: () => onTap(2),
                ),
                _navItem(
                  iconPath: 'assets/icons/profile.svg',
                  label: "Profile",
                  isActive: currentIndex == 3,
                  onPressed: () => onTap(3),
                ),
              ],
            ),

            // Center Floating Button
            Positioned(
              top: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: onCenterTap,
                child: Container(
                  height: 46,
                  width: 46,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withValues(alpha: .25),
                        blurRadius: 4,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/plus.svg',
                      height: 28,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
