import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OTPInputController extends GetxController {
  final int otpLength = 6;
  late List<TextEditingController> digitControllers;
  late List<FocusNode> focusNodes;
  final otpValue = ''.obs;

  @override
  void onInit() {
    super.onInit();
    digitControllers = List.generate(otpLength, (_) => TextEditingController());
    focusNodes = List.generate(otpLength, (_) => FocusNode());
    _setupListeners();
  }

  void _setupListeners() {
    for (var i = 0; i < otpLength; i++) {
      digitControllers[i].addListener(() => _handleDigitChange(i));
    }
  }

  void _handleDigitChange(int index) {
    final value = digitControllers[index].text;
    
    if (value.isNotEmpty) {
      if (index < otpLength - 1) {
        focusNodes[index + 1].requestFocus();
      } else {
        focusNodes[index].unfocus();
      }
    }
    
    otpValue.value = digitControllers.map((c) => c.text).join();
  }

  void clear() {
    for (var controller in digitControllers) {
      controller.clear();
    }
    otpValue.value = '';
    focusNodes.first.requestFocus();
  }

  @override
  void onClose() {
    for (var controller in digitControllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.onClose();
  }
}