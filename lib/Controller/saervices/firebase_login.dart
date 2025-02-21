import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService_login {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> signInWithPhone(String fullPhoneNumber, String password) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(fullPhoneNumber).get();

      if (userDoc.exists) {
        String storedPassword = userDoc['password'];

        if (storedPassword == password) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      print("Error during sign-in: $e");
      return false;
    }
  }
}
