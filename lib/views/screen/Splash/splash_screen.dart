import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_extension/controller/splash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<Offset> splash1Slide;
  late Animation<double> splash1Fade;

  late Animation<double> splash2Fade;
  late Animation<double> splash2Scale;
  late Animation<Offset> splash2Slide;

  late Animation<double> splash3Fade;
  late Animation<Offset> splash3Slide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5400),
    );

    splash1Slide =
        Tween(
          begin: Offset.zero,
          end: const Offset(0, 0), // move RIGHT
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.22, 0.40, curve: Curves.easeInOut),
          ),
        );

    splash1Fade = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.25, 0.40)),
    );

    splash2Fade = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.40, 0.55, curve: Curves.easeIn),
      ),
    );

    splash2Scale = Tween(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.40, 0.55, curve: Curves.easeOutBack),
      ),
    );

    splash2Slide = Tween(begin: Offset.zero, end: const Offset(-1.2, 0))
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.60, 0.78, curve: Curves.easeInOut),
          ),
        );

    splash3Fade = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.78, 1.0, curve: Curves.easeIn),
      ),
    );

    splash3Slide =
        Tween(
          begin: const Offset(1.2, 0), // start OFFSCREEN right
          end: Offset.zero, // end at center
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.78, 1.0, curve: Curves.easeOutCubic),
          ),
        );

    _controller.forward();

    Future.delayed(const Duration(milliseconds: 5400), () {
      Get.find<SplashController>().jumpNextScreen();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget splash1() {
    return SlideTransition(
      position: splash1Slide,
      child: FadeTransition(
        opacity: splash1Fade,
        child: Image.asset(
          'assets/images/splash1.png',
          fit: BoxFit.fitHeight,
          height: double.infinity,
        ),
      ),
    );
  }

  Widget splash2() {
    return SlideTransition(
      position: splash2Slide,
      child: FadeTransition(
        opacity: splash2Fade,
        child: ScaleTransition(
          scale: splash2Scale,
          child: Center(
            child: Image.asset('assets/images/splash2.png', width: 120),
          ),
        ),
      ),
    );
  }

  Widget splash3() {
    return SlideTransition(
      position: splash3Slide,
      child: FadeTransition(
        opacity: splash3Fade,
        child: Center(
          child: Image.asset('assets/images/splash3.png', width: 180),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [splash1(), splash2(), splash3()]),
    );
  }
}
