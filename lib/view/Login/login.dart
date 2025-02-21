import 'package:country_picker/country_picker.dart';
import 'package:creditsea/Constants/color.dart';
import 'package:creditsea/Constants/share_phone.dart';
import 'package:creditsea/Controller/OTP_Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var selectedCountryCode = "+91".obs;
  var selectedFlag = "🇮🇳".obs;
  var isChecked = false.obs;
    var phoneNumber = ''.obs;
  var isLoading = false.obs;
  final phoneController = TextEditingController();
   final OTPController otpController = Get.put(OTPController());


    void requestOTP() {
        String fullNumber = "$selectedCountryCode${phoneController.text.trim()}";
       otpController.sendOTP(fullNumber);
  }


    void goToNextPage() {
    final PageController controller = Get.find<PageController>();
    controller.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void goToPreviousPage() {
    final PageController controller = Get.find<PageController>();
    controller.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
  


}

class Login extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());
    final SharedController sharedController = Get.put(SharedController()); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: MyColors.myColor1,
        ),
      ),
      body: Column(
        children: [
          Expanded(
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
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Welcome to Credit Sea!",
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Mobile Number",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            showCountryPicker(
                              context: context,
                              showPhoneCode: true,
                              onSelect: (Country country) {
                                controller.selectedCountryCode.value =
                                    "+${country.phoneCode}";
                                controller.selectedFlag.value = country.flagEmoji;
                              },
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Obx(() => Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(controller.selectedFlag.value,
                                        style: const TextStyle(fontSize: 20)),
                                    const SizedBox(width: 5),
                                    Text(controller.selectedCountryCode.value,
                                        style: const TextStyle(fontSize: 16)),
                                    const Icon(Icons.arrow_drop_down, size: 20),
                                  ],
                                )),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: controller.phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              hintText: "Please enter your mobile no.",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Obx(() => Row(
                          children: [
                            Checkbox(
                              value: controller.isChecked.value,
                              onChanged: (value) {
                                controller.isChecked.value = value!;
                              },
                            ),
                            const Flexible(
                              child: Text(
                                "By continuing, you agree to our privacy policies and Terms & Conditions.",
                                style: TextStyle(fontSize: 14),
                                textAlign: TextAlign.left,
                                softWrap: true,
                              ),
                            )
                          ],
                        )),
                    const SizedBox(height: 20),
                   SizedBox(
  width: double.infinity,
  child: ElevatedButton(
      onPressed: () {
            String fullNumber = "${controller.selectedCountryCode.value}${controller.phoneController.text.trim()}";
                          sharedController.phoneNumber.value = fullNumber;
         controller.requestOTP();
      } ,
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),
    child: const Text(
      "Request OTP",
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
  ),
),
                    const SizedBox(height: 20,),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: TextButton(
                          onPressed: () {},
                          child: const Text("Existing User? Sign in")),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
