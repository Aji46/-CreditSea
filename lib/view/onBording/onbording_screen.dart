import 'package:creditsea/Constants/color.dart';
import 'package:creditsea/view/Createpassword/Create_password.dart';
import 'package:creditsea/view/Login/login.dart';
import 'package:creditsea/view/OtpScreen/opt.dart';
import 'package:creditsea/view/phone_number_password/Phone_num_pass.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatelessWidget {
  late final PageController _pageController;
  final RxInt _currentPage = 0.obs;
  final String? phoneNumber;
  final String? verificationId;
  final int initialPage;

  OnboardingScreen({
    Key? key,
    this.phoneNumber,
    this.verificationId,
    this.initialPage = 0,
  }) : super(key: key) {
    _pageController = PageController(initialPage: initialPage);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pageController.jumpToPage(initialPage);
      _currentPage.value = initialPage;
    });

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: MyColors.myColor1,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Get.back(),
          ),
        ),
      ),
      backgroundColor: MyColors.myColor1,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              _currentPage.value = index;
            },
            children: [
              _buildPage(
                "assets/home_logo.png",
                "assets/loin_page_icon.png",
                "Flexible Loan Options",
                "Loan types to cater to different financial needs",
                Login(),
              ),
              _buildPage(
                "assets/home_logo.png",
                "assets/Frame .png",
                "Instant Loan Approval",
                "Users will receive approval within minutes",
                OTPPage(
                 
                ),
              ),
                   _buildPage(
                "assets/home_logo.png",
                "assets/Frame 2.png",
                "24x7 Customer Care",
                "Dedicated customer support team",
                CreatePassword(),
              ),
                     _buildPage(
                "assets/home_logo.png",
                "assets/Frame 2.png",
                "24x7 Customer Care",
                "Dedicated customer support team",
                PhoneNumPass(),
              ),
            ],
          ),
          Positioned(
            top: 360,
            left: 0,
            right: 0,
            child: Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage.value == index
                        ? Colors.white
                        : Colors.white.withOpacity(0.5),
                  ),
                ),
              ),
            )),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(
    String logoAsset,
    String iconAsset,
    String title,
    String subtitle,
    Widget content,
  ) {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: Image.asset(logoAsset),
        ),
        const SizedBox(height: 15),
        Align(
          alignment: Alignment.center,
          child: Image.asset(iconAsset),
        ),
        const SizedBox(height: 15),
        Text(
          title,
          style: const TextStyle(color: MyColors.mycolor2, fontSize: 20),
        ),
        Text(
          subtitle,
          style: const TextStyle(color: MyColors.mycolor2),
        ),
        const SizedBox(height: 15),
        Expanded(
          child: content,
        ),
      ],
    );
  }
}