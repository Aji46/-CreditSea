import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creditsea/view/panCard/pan.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Constants/color.dart';
import '../../Constants/share_phone.dart';
import '../../Controller/saervices/email_OTP_Controller.dart';
import '../Login/widgets/Email_otp.dart';

class PersonalEmail extends StatefulWidget {
  final String phoneNumber;

  const PersonalEmail({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<PersonalEmail> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalEmail> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final SharedController sharedController = Get.find<SharedController>();
  final OTPInputController otpController = Get.put(OTPInputController());

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _savePersonalDetails() async {
    if (_formKey.currentState!.validate()) {
      try {
        DocumentReference userDoc = _firestore.collection("users").doc(widget.phoneNumber);
        DocumentSnapshot docSnapshot = await userDoc.get();

        if (docSnapshot.exists) {
          await userDoc.set({"email": _emailController.text.trim()}, SetOptions(merge: true));

          Get.snackbar("Success", "Details updated successfully!");
          otpController.sendOTP(_emailController.text.trim());

        } else {
          Get.snackbar("Error", "No record found for this phone number.");
        }
      } catch (e) {
        Get.snackbar("Error", "Failed to save details: $e");
      }
    }
  }

  Future<void> _checkEmailVerification() async {
    User? user = _auth.currentUser;
    await user?.reload();

    if (user?.emailVerified == true) {
      Get.snackbar("Success", "Email Verified!");
    } else {
      Get.snackbar("Error", "Please verify your email first.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: MyColors.backgroundColor),
      backgroundColor: MyColors.backgroundColor,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress Steps
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildProgressItem(1, "Register", true),
                  _buildProgressItem(2, "Offer", false),
                  _buildProgressItem(3, "Approval", false),
                ],
              ),
              const SizedBox(height: 32),

              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Color.fromARGB(228, 239, 238, 238), width: 2),
                ),
                child: Column(
                  children: [
                    const Text("Personal Email ID", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                    Image.asset('assets/email.png'),
                    const SizedBox(height: 20),

                    _buildTextField("Email ID*", _emailController),

                    const SizedBox(height: 24),
                    EmailOTPInputField(),

                    const SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: () {
                        if (otpController.verifyOTP()) {
                          Get.snackbar("Success", "OTP Verified Successfully!");
                          

                              Get.offAll(() => Pan(phoneNumber: widget.phoneNumber)); 


                        } else {
                          Get.snackbar("Error", "Invalid OTP. Please try again.");
                        }
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                      child: const Text('Verify OTP', style: TextStyle(color: Colors.white)),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
      validator: (value) => value!.isEmpty ? "Please enter $label" : null,
    );
  }
}

  Widget _buildProgressItem(int number, String label, bool isActive) {
    return Column(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: isActive ? Colors.blue : Colors.grey[300],
          child: Text(number.toString(), style: TextStyle(color: isActive ? Colors.white : Colors.grey[600]))),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: isActive ? Colors.blue : Colors.grey[600], fontWeight: FontWeight.w500)),
      ],
    );
  }

