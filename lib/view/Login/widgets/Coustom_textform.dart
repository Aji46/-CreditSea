import 'package:creditsea/Controller/password.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CustomPasswordField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final ValueChanged<String>? onChanged;

  const CustomPasswordField({
    Key? key,
    this.controller,
    this.hintText = 'Enter password',
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PasswordController passwordController = Get.put(PasswordController());

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Obx(() => TextField(
  controller: controller,
  obscureText: passwordController.obscureText.value,
  onChanged: onChanged,
  decoration: InputDecoration(
    hintText: hintText,
    hintStyle: const TextStyle(
      color: Colors.grey,
      fontSize: 16,
    ),
    border: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey), 
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey), 
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue, width: 2), 
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 16,
    ),
    suffixIcon: IconButton(
      icon: Icon(
        passwordController.obscureText.value
            ? Icons.visibility_off
            : Icons.visibility,
        color: Colors.grey,
      ),
      onPressed: passwordController.togglePasswordVisibility,
    ),
  ),
)
),
    );
  }
}
