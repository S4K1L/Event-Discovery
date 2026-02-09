import 'package:get/get.dart';

class LanguageController extends GetxController {
  final RxString selectedLanguage = "English".obs;

  final List<String> languages = const [
    "English",
    "French",
    "German",
    "Italian",
    "Espanol",
    "Portuguese",
  ];

  void changeLanguage(String language) {
    selectedLanguage.value = language;
  }
}
