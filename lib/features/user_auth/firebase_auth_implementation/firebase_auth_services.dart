import 'package:firebase_auth/firebase_auth.dart';
import 'package:world_time/global/common/toast.dart';

class FirebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (error) {
      if (error.code == "email-already-in-use") {
        showToast(message: "The email is already in use.");
      } else if (error.code == "week-password") {
        showToast(message: "Week Password");
      } else if (error.code == "invalid-email") {
        showToast(message: "Invalid email. Try again.");
      } else {
        showToast(message: "An error occurred: ${error.code}");
      }
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (error) {
      if (error.code == "invalid-credential" || error.code == "invalid-email") {
        showToast(message: "Invalid email or password.");
      } else {
        showToast(message: "An error occurred: ${error.code}");
      }
    }
    return null;
  }
}
