import 'package:creditsea/Constants/share_phone.dart';
import 'package:creditsea/firebase_options.dart';
import 'package:creditsea/view/Createpassword/Create_password.dart';
import 'package:creditsea/view/Login/login.dart';
import 'package:creditsea/view/OtpScreen/opt.dart';
import 'package:creditsea/view/onBording/onbording_screen.dart';
import 'package:creditsea/view/spalsh_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

void main() async {

    // Get.put(OTPInputController());
    Get.put(SharedController());
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env"); 
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      getPages: [
        GetPage(name: '/splash', page: () => const SplashScreen()),
        GetPage(name: '/login', page: () => Login()),
         GetPage(name: '/otp', page: () =>  OTPPage()),
        GetPage(name: '/onboard', page: () => OnboardingScreen()),
        GetPage(name: '/home', page: () => CreatePassword()),
      ],
    );
  }
}
// initialPage: 2