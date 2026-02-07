import 'package:flutter_extension/views/screen/auth/login.dart';
import 'package:flutter_extension/views/screen/auth/signup.dart';
import 'package:flutter_extension/views/screen/home/home_screen.dart';
import 'package:get/get.dart';

import '../views/screen/splash/splash_screen.dart';

class AppRoutes {
  static String splashScreen = "/splash_screen";
  static String homeScreen = "/home_screen";
  static String loginScreen = "/login_screen";
  static String signupScreen = "/signup_screen";

  static List<GetPage> page = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: homeScreen, page: () => const HomeScreen()),
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(name: signupScreen, page: () => const SignUpScreen()),
  ];
}
