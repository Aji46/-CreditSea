import 'package:creditsea/Constants/color.dart';
import 'package:creditsea/view/LoanApplicationPage/Home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<void> checkPanVerification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isPanVerified = prefs.getBool('isPanVerified') ?? false;

    if (isPanVerified) {
      Get.offAll(() => const LoanApplicationPage());
    } else {
      Get.offNamed('/onboard'); 
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), checkPanVerification);

    return Scaffold(
      backgroundColor: MyColors.myColor1,
      body: Center(
        child: Image.asset("assets/logo.png"),
      ),
    );
  }
}
