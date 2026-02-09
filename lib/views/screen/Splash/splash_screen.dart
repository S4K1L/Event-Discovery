import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:flutter_extension/controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 5), () {
      Get.find<SplashController>().jumpNextScreen();
    });

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
                  'assets/images/splash2.png',
                  width: screenWidth,
                  height: screenHeight,
                  fit: BoxFit.contain,
                )
                .animate()
                .moveX(
                  begin: -400,
                  end: 0,
                  duration: 1200.ms,
                  curve: Curves.easeInOutCubic,
                )
                .custom(
                  duration: 1200.ms,
                  builder: (context, value, child) {
                    final width =
                        (screenWidth * 1.8) * (1 - value) + (60 * value);
                    final height =
                        (screenWidth * 1.8) * (1 - value) + (80 * value);
                    return SizedBox(width: width, height: height, child: child);
                  },
                )
                .fadeOut(delay: 1200.ms, duration: 400.ms),

            Image.asset('assets/images/splash3.png', height: 100, width: 250)
                .animate(delay: 1600.ms)
                .slideX(
                  begin: 1.2,
                  end: 0,
                  duration: 800.ms,
                  curve: Curves.easeOutCubic,
                )
                .fadeIn(duration: 500.ms),
          ],
        ),
      ),
    );
  }
}
