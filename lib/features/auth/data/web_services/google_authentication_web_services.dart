import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthenticationWebServices {
  // Google Sign-In Method with Error Management
  Future<String?> signInWithGoogle() async {
    try {
      // Trigger the Google Sign-In authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // If the user cancels the sign-in
      if (googleUser == null) {
        return "Sign-in process was canceled.";
      }

      // Obtain the auth details from the Google Sign-In request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser.authentication;

      // Create a credential from the access token and id token
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Sign in to Firebase using the credential
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Check if the user was successfully signed in
      if (userCredential.user != null) {
        return "User signed in successfully with Google";
      }

      return "Failed to sign in with Google";
    } on FirebaseAuthException catch (e) {
      return _handleGoogleSignInErrors(e);
    } catch (e) {
      return "An unknown error occurred: ${e.toString()}";
    }
  }

  // Error handler for Google Sign-In FirebaseAuth errors
  String _handleGoogleSignInErrors(FirebaseAuthException e) {
    switch (e.code) {
      case 'account-exists-with-different-credential':
        return "Account exists with different credentials.";
      case 'invalid-credential':
        return "Invalid credentials. Please try again.";
      case 'user-disabled':
        return "This user account has been disabled.";
      case 'operation-not-allowed':
        return "Operation not allowed. Please enable Google Sign-In in Firebase.";
      default:
        return "An error occurred: ${e.message}";
    }
  }
}
