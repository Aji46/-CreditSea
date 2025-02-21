import 'dart:convert';
import 'dart:math';

import 'package:creditsea/view/onBording/onbording_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OTPController extends GetxController {
  static final String _accountSID = dotenv.env['TWILIO_ACCOUNT_SID'] ?? "";
  static final String _authToken = dotenv.env['TWILIO_AUTH_TOKEN'] ?? "";
  static final String _twilioPhoneNumber = dotenv.env['TWILIO_PHONE_NUMBER'] ?? "";

  final phone = ''.obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  late String _generatedOTP;

  @override
  void onInit() {
    super.onInit();
    if (_accountSID.isEmpty || _authToken.isEmpty || _twilioPhoneNumber.isEmpty) {
      print("⚠️ Twilio API credentials are missing. Make sure to load .env properly.");
    }
  }

  String _generateOTP() {
    final random = Random.secure();
    return List.generate(6, (_) => random.nextInt(10)).join();
  }

  bool _isValidPhoneNumber(String phone) {
    return phone.length >= 10 && phone.startsWith('+');
  }

  Future<void> sendOTP(String phoneNumber) async {
    try {
      if (!_isValidPhoneNumber(phoneNumber)) {
        throw Exception("Please enter a valid phone number with country code (e.g., +9134567890)");
      }

      isLoading.value = true;
      _generatedOTP = _generateOTP();
      
      final uri = Uri.parse("https://api.twilio.com/2010-04-01/Accounts/$_accountSID/Messages.json");

      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Basic ${base64Encode(utf8.encode("$_accountSID:$_authToken"))}',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'To': phoneNumber,
          'From': _twilioPhoneNumber,
          'Body': 'Your verification code is: $_generatedOTP. Do not share this with anyone.',
        },
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () => throw Exception("Request timed out. Please try again."),
      );

      final responseData = json.decode(response.body);
      print("📩 Twilio Response: $responseData");

      if (response.statusCode >= 200 && response.statusCode < 300) {
        phone.value = phoneNumber;
        Get.to(() => OnboardingScreen(initialPage: 1, phoneNumber: phoneNumber));
      } else {
        throw Exception(responseData['message'] ?? "Failed to send verification code");
      }
    } catch (e) {
      errorMessage.value = e.toString();
      print("❌ Error: ${errorMessage.value}");
      Get.snackbar(
        "Error",
        errorMessage.value,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyOTP(String enteredOTP) async {
    try {
      if (enteredOTP.isEmpty) throw Exception("Please enter the verification code");

      if (enteredOTP == _generatedOTP) {
        Get.snackbar(
          "Success",
          "Verification successful!",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        await Future.delayed(const Duration(seconds: 1));
        Get.offAll(() => OnboardingScreen(initialPage: 2));
      } else {
        throw Exception("Invalid verification code. Please try again.");
      }
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar(
        "Error",
        errorMessage.value,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    _generatedOTP = '';
    super.onClose();
  }
}
