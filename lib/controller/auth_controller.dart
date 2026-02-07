import 'package:get/get.dart';

class AuthController extends GetxController {
  RxBool checkBox = false.obs;
  RxBool otpError = false.obs;

  void setOtpError(bool value) => otpError.value = value;

  void clearOtpError() => otpError.value = false;

  void toggleOtpError() {
    otpError.value = !otpError.value;
  }

  void toggleCheckbox() {
    checkBox.value = !checkBox.value;
  }

  bool verifyOtp(String inputOtp) {
    // Simulate OTP verification logic
    const correctOtp =
        "1234"; // This should come from your backend in real scenarios
    if (inputOtp == correctOtp) {
      otpError.value = false;
      return true;
    } else {
      otpError.value = true;
      return false;
    }
  }

  void clear() {
    otpError.value = false;
    checkBox.value = false;
  }
}
