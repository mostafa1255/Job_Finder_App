import 'package:firebase_auth/firebase_auth.dart';

class FireBaseAuthenticationWebServices {
  final FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;

  // Method to get the current user
  User? getCurrentUser() {
    return _fireBaseAuth.currentUser;
  }

  //Sign Up
  Future<String?> signUp({
    required String email,
    required String password,
    required String fullName, // Add fullName as a required parameter
  }) async {
    try {
      final UserCredential credential = await _fireBaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (credential.user != null) {
        // Update the display name (full name) for the new user
        await credential.user!.updateDisplayName(fullName);
        await credential.user!.reload(); // Reload the user to apply the changes

        return "User signed up successfully";
      }
      return "Failed to sign up user";
    } on FirebaseAuthException catch (e) {
      return _handleAuthErrors(e);
    } catch (e) {
      return "An unknown error occurred: ${e.toString()}";
    }
  }

  //Sign In
  Future<String?> signIn(
      {required String email, required String password}) async {
    try {
      final UserCredential credential = await _fireBaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        return "User signed in successfully";
      }
      return "Failed to sign in user";
    } on FirebaseAuthException catch (e) {
      print(e);
      return _handleAuthErrors(e);
    } catch (e) {
      return "An unknown error occurred: ${e.toString()}";
    }
  }

  //Sign Out
  Future<void> signOut() async {
    try {
      await _fireBaseAuth.signOut();
      print("User signed out successfully");
    } catch (e) {
      print("An error occurred while signing out: ${e.toString()}");
    }
  }

  // Forgot Password
  Future<String?> resetPassword({required String email}) async {
    try {
      await _fireBaseAuth.sendPasswordResetEmail(email: email);
      return "Password reset email sent";
    } on FirebaseAuthException catch (e) {
      return _handleAuthErrors(e);
    } catch (e) {
      return "An unknown error occurred: ${e.toString()}";
    }
  }

  // Handle FirebaseAuth errors
  String _handleAuthErrors(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return "The email address is already in use by another account.";
      case 'invalid-email':
        return "The email address is not valid.";
      case 'operation-not-allowed':
        return "Email/password accounts are not enabled.";
      case 'weak-password':
        return "The password is too weak.";
      case 'user-not-found':
        return "No user found with this email.";
      case 'wrong-password':
        return "Wrong password provided for this user.";
      case 'user-disabled':
        return "This user account has been disabled.";
      default:
        return "An error occurred: ${e.message}";
    }
  }
}
