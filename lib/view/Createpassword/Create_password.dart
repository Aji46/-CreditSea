import 'package:creditsea/Constants/color.dart';
import 'package:creditsea/Constants/share_phone.dart';
import 'package:creditsea/Controller/firebase.dart';
import 'package:creditsea/Controller/password.dart';
import 'package:creditsea/view/Login/widgets/Coustom_textform.dart';
import 'package:creditsea/view/onBording/onbording_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatePassword extends StatelessWidget {
  final PasswordController passwordController = Get.put(PasswordController());
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController confirmPasswordTextController = TextEditingController();
  final SharedController sharedController = Get.find<SharedController>(); 
   final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final String phoneNumber = sharedController.phoneNumber.value;

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
                  "Create a password",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const Text("Enter password"),
              CustomPasswordField(
                controller: passwordTextController,
                hintText: 'Enter your password',
                onChanged: (value) {
                  print("Password: $value");
                },
              ),
              const Text("Re-enter password"),
              CustomPasswordField(
                controller: confirmPasswordTextController,
                hintText: 'Enter your password',
                onChanged: (value) {
                  print("Password: $value");
                },
              ),
              const Text(
                "*Your password must include at least 8 characters, inclusive of at least 1 special character",
                style: TextStyle(color: MyColors.mycolor5),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    String password = passwordTextController.text.trim();
                    String confirmPassword = confirmPasswordTextController.text.trim();

                    if (phoneNumber.isEmpty) {
                      Get.snackbar("Error", "Phone number is missing");
                      return;
                    }

                    if (password.isEmpty || confirmPassword.isEmpty) {
                      Get.snackbar("Error", "Please fill in all fields");
                      return;
                    }

                    if (password != confirmPassword) {
                      Get.snackbar("Error", "Passwords do not match");
                      return;
                    }

                    if (!_isPasswordValid(password)) {
                      Get.snackbar("Error", "Password must be at least 8 characters long and include a special character");
                      return;
                    }

                    try {
                      await _authService.signUpWithPhone(phoneNumber, password);
                      Get.snackbar("Success", "Account created successfully");
                   
                      Get.offAll(() => OnboardingScreen(initialPage: 3));

                    } catch (e) {
                      Get.snackbar("Error", "Failed to create account: $e");
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
                    "Proceed",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),
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