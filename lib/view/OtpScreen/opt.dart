import 'package:creditsea/Constants/color.dart';
import 'package:creditsea/Controller/OTP_Controller.dart';
import 'package:creditsea/Controller/OTP_inputController.dart';
import 'package:creditsea/view/Login/widgets/OTPinput.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OTPPage extends GetView<OTPController> {
  final OTPInputController inputController = Get.put(OTPInputController());
  
  OTPPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    controller.phone.value = args['phoneNumber'] ?? "";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.myColor1,
        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      backgroundColor: MyColors.myColor1,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: MyColors.mycolor2,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                const _HeaderSection(),
                const SizedBox(height: 20),
                OTPInputField(),
                const SizedBox(height: 20),
                _ErrorMessage(),
                const SizedBox(height: 10),
                _VerifyButton(),
                const SizedBox(height: 510,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderSection extends GetView<OTPController> {
  const _HeaderSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Enter OTP",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Obx(() => Text(
          "Verify OTP sent to ${controller.phone}",
          style: const TextStyle(fontWeight: FontWeight.w500),
        )),
      ],
    );
  }
}

class _ErrorMessage extends GetView<OTPController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.errorMessage.value.isNotEmpty
      ? Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            controller.errorMessage.value,
            style: const TextStyle(color: Colors.red),
          ),
        )
      : const SizedBox.shrink());
  }
}

class _VerifyButton extends GetView<OTPController> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Obx(() => ElevatedButton(
        onPressed: () => controller.verifyOTP(Get.find<OTPInputController>().otpValue.value),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: controller.isLoading.value
          ? const CircularProgressIndicator(color: Colors.white)
          : const Text(
              "Verify",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
      )),
    );
  }
}