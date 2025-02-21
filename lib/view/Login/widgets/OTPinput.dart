import 'package:creditsea/Controller/OTP_inputController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class OTPInputField extends GetView<OTPInputController> {
  const OTPInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(6, (index) {
            return SizedBox(
              width: 45,
              child: RawKeyboardListener(
                focusNode: FocusNode(),
                onKey: (event) => _handleBackspace(event, index),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: controller.digitControllers[index],
                  focusNode: controller.focusNodes[index],
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    counterText: "",
                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(1),
                  ],
                  onChanged: (value) => _handleInput(value, index),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 20),
        // Example of using the reactive state
        Obx(() => Text(
          'Current OTP: ${controller.otpValue}',
          style: const TextStyle(fontSize: 16),
        )),
      ],
    );
  }

  void _handleInput(String value, int index) {
    if (value.isNotEmpty) {
      if (index < 5) {
        controller.focusNodes[index + 1].requestFocus();
      } else {
        controller.focusNodes[index].unfocus();
      }
    }
  }

  void _handleBackspace(RawKeyEvent event, int index) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.backspace) {
        if (controller.digitControllers[index].text.isEmpty && index > 0) {
          controller.focusNodes[index - 1].requestFocus();
          controller.digitControllers[index - 1].clear();
        }
      }
    }
  }
}