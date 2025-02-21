import 'package:country_picker/country_picker.dart';
import 'package:creditsea/Constants/color.dart';
import 'package:creditsea/Constants/share_phone.dart';
import 'package:creditsea/Controller/password.dart';
import 'package:creditsea/Controller/saervices/firebase_login.dart';
import 'package:creditsea/view/Login/login.dart';
import 'package:creditsea/view/Login/widgets/Coustom_textform.dart';
import 'package:creditsea/view/Perosnal_Information/PersonalDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneNumPass extends StatelessWidget {
  final PasswordController passwordController = Get.put(PasswordController());
  final TextEditingController passwordTextController = TextEditingController();
  final SharedController sharedController = Get.find<SharedController>(); 
  final AuthService_login _authService = AuthService_login();

  @override
  Widget build(BuildContext context) {
    final String phoneNumber = sharedController.phoneNumber.value;
    final LoginController controller = Get.put(LoginController());

    print("Phone Number: $phoneNumber");

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: MyColors.myColor1,
        ),
      ),
      body: SingleChildScrollView(
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
                  "Please enter your credentials",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const Text("Enter Phone Number"),
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
              const Text("Enter password"),
              CustomPasswordField(
                controller: passwordTextController,
                hintText: 'Enter your password',
                onChanged: (value) {
                  print("Password: $value");
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    String password = passwordTextController.text.trim();
                    String fullPhoneNumber =
                        "${controller.selectedCountryCode.value}${controller.phoneController.text.trim()}";

                    if (fullPhoneNumber.isEmpty) {
                      Get.snackbar("Error", "Phone number is missing");
                      return;
                    }

                    if (password.isEmpty) {
                      Get.snackbar("Error", "Please fill in all fields");
                      return;
                    }

                    if (!_isPasswordValid(password)) {
                      Get.snackbar("Error", "Password must be at least 8 characters long and include a special character");
                      return;
                    }

                    try {
                      bool isAuthenticated = await _authService.signInWithPhone(fullPhoneNumber, password);

                      if (isAuthenticated) {
                        Get.snackbar("Success", "Login successful");
                         Get.offAll(() => PersonalDetailsScreen(phoneNumber: fullPhoneNumber)); 
                      } else {
                        Get.snackbar("Error", "Invalid phone number or password");
                      }
                    } catch (e) {
                      Get.snackbar("Error", "Failed to login: $e");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const Text(
                    "Sign In",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: TextButton(
                    onPressed: () {},
                    child: const Text("New to CreditSea? Create an account")),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool _isPasswordValid(String password) {
    final RegExp passwordRegex = RegExp(r'^(?=.*?[!@#\$&*~]).{8,}$');
    return passwordRegex.hasMatch(password);
  }
}