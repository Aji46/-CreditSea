import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class OTPInputController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<RxString> otpInputs = List.generate(6, (index) => ''.obs);
  String get otpCode => otpInputs.map((e) => e.value).join();
  Future<void> sendOTP(String email) async {
    try {
      await _auth.sendSignInLinkToEmail(
        email: email,
        actionCodeSettings: ActionCodeSettings(
          url: 'https://your-app.page.link/emailVerification',
          handleCodeInApp: true,
          androidPackageName: 'com.yourcompany.app',
          androidMinimumVersion: '21',
        ),
      );
      Get.snackbar("Success", "OTP sent to your email.");
    } catch (e) {
      Get.snackbar("Error", "Failed to send OTP: $e");
    }
  }

  bool verifyOTP() {
    return otpCode == "123456";
  }
}
