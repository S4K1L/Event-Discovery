import 'package:get/get.dart';

class HomeController extends GetxController {
  var selectedLocation = "Near You".obs;
  var selectedTimeFilter = "This Week".obs;

  void setLocation(String value) {
    selectedLocation.value = value;
  }

  void setTimeFilter(String value) {
    selectedTimeFilter.value = value;
  }
}
