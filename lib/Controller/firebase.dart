import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<void> signUpWithPhone(String phoneNumber, String password) async {
    await _firestore.collection("users").doc(phoneNumber).set({
      "phoneNumber": phoneNumber,
      "password": password,
    });
  }


  Future<bool> loginWithPhone(String phoneNumber, String password) async {
    DocumentSnapshot userDoc =
        await _firestore.collection("users").doc(phoneNumber).get();

    if (userDoc.exists) {
      String storedPassword = userDoc["password"];
      return storedPassword == password; 
    }
    return false;
  }
}
