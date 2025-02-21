import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../Controller/saervices/email_OTP_Controller.dart';

class EmailOTPInputField extends StatelessWidget {
  final OTPInputController otpController = Get.find();

  EmailOTPInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(6, (index) {
            return SizedBox(
              width: 45,
              child: Obx(() => TextFormField(
                    controller: TextEditingController(text: otpController.otpInputs[index].value),
                    focusNode: FocusNode(),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      counterText: "",
                      contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(1),
                    ],
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        otpController.otpInputs[index].value = value;
                        if (index < 5) {
                          FocusScope.of(context).nextFocus();
                        }
                      }
                    },
                  )),
            );
          }),
        ),
        const SizedBox(height: 20),
        Obx(() => Text(
              'Entered OTP: ${otpController.otpInputs.map((e) => e.value).join()}',
              style: const TextStyle(fontSize: 16),
            )),
      ],
    );
  }
}
