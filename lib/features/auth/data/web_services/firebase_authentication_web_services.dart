import 'package:firebase_auth/firebase_auth.dart';

class FireBaseAuthenticationWebServices {
  final FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;
  //Sign Up
  Future<User?> signUp({required email, required password}) async {
    try {
      final UserCredential credential = await _fireBaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (credential.user != null) {
        return credential.user;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

//Sign In
  Future<User?> signIn({required email, required password}) async {
    try {
      final UserCredential credential = await _fireBaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      if (credential.user != null) {
        return credential.user;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

//Sign Out
  Future<void> signOut() async {
    _fireBaseAuth.signOut();
  }

// Forgot Password
  Future<void> resetPassword({required String email}) async {
    try {
      await _fireBaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }
}
