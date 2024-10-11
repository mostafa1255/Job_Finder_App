// ignore_for_file: unused_field

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jop_finder_app/features/auth/data/model/UserProfile_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:jop_finder_app/features/auth/data/model/user_model.dart';
import 'package:jop_finder_app/features/auth/data/web_services/firebase_authentication_web_services.dart';

class FirebaseProfileWebServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FireBaseAuthenticationWebServices _authenticationWebServices;

  FirebaseProfileWebServices(this._authenticationWebServices);

  // Get the current user's ID from FirebaseAuth
  String? getCurrentUserId() {
    return   "nwrmkmITTuOuL76MvGAa" ;
  }
  

  // Fetch user information from Firestore
  Future<UserModel?> getUserInfo() async {
    String? userId = getCurrentUserId();
    if (userId == null) return null;
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userId).get();
      if (userDoc.exists) {
        return UserModel.fromFirestore(userDoc);
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Update user information in Firestore

  //  pickImage method
  Future<File?> pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
          source:
              ImageSource.camera); // Changed to gallery for broader use case
      if (pickedFile != null) {
        return File(pickedFile.path);
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // New method to upload image and update user's imageUrl
  Future<bool> uploadImageAndUpdateUser(File imageFile) async {
    String? userId = getCurrentUserId();
    if (userId == null) return false;
    try {
      // Upload image to Firebase Storage
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref =
          FirebaseStorage.instance.ref().child('user_images/$userId/$fileName');
      UploadTask uploadTask = ref.putFile(imageFile);
      final snapshot = await uploadTask.whenComplete(() {});
      final imageUrl = await snapshot.ref.getDownloadURL();

      // Update user's imageUrl in Firestore
      await _firestore.collection('users').doc(userId).update({
        'imageUrl': imageUrl,
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool?> uploadFileAndUpdateUser(FilePickerResult cvPdf) async {
    String? userId = getCurrentUserId();
    if (userId == null) return false;
    try {
      // Ensure the file name retains the .pdf extension
      String fileName =
          "${DateTime.now().millisecondsSinceEpoch.toString()}.pdf";
      Reference ref = FirebaseStorage.instance.ref().child('CVs/$fileName');
      UploadTask uploadTask;
      // Check if running on web
      if (kIsWeb) {
        // Use bytes for uploading if on web
        final bytes = cvPdf.files.first.bytes;
        if (bytes == null) throw Exception("File bytes are null");
        uploadTask = ref.putData(
            bytes, SettableMetadata(contentType: 'application/pdf'));
      } else {
        // Use the file path for uploading if not on web
        File file = File(cvPdf.files.single.path!);
        uploadTask =
            ref.putFile(file, SettableMetadata(contentType: 'application/pdf'));
      }
      final snapshot = await uploadTask.whenComplete(() {
        // Perform any actions after the file is uploaded
      });
      final cvUrl = await snapshot.ref.getDownloadURL();
      await _firestore.collection('users').doc(userId).update({
        'cvUrl': cvUrl,
      });
      // Update the user's document with the CV URL
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<void> openPdf(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  //i want to make a method to update the bio in the firestore
  Future<bool> updateBio(String bio) async {
    String? userId = getCurrentUserId();
    if (userId == null) return false;

    try {
      await _firestore.collection('users').doc(userId).update({
        // Update the bio in the user's document that in the userprofile map field in the firestore and not to update the whole userprofile map field but just the bio field
        'profile.bio': bio,
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  //i want to make a method to update the name and the email and the phone number in the firestore that in the user's document
  Future<bool> customUpdateToFirebase(String key, String value) async {
    String? userId = getCurrentUserId();
    if (userId == null) return false;
    try {
      await _firestore.collection('users').doc(userId).update({
        key: value,
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
  Future<bool> customUpdateToFirebaseProfile(String key, String value) async {
    String? userId = getCurrentUserId();
    if (userId == null) return false;
    try {
      await _firestore.collection('users').doc(userId).update({
        // Update the bio in the user's document that in the userprofile map field in the firestore and not to update the whole userprofile map field but just the bio field
        'profile.$key': value,
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  //the previous method to update the education in the firestore but i want it not to update the whole userprofile map field but just the education field and not to update i need it to add a new education to the list of educations in the education field
  Future<bool> addEducation(Education education) async {
    String? userId = getCurrentUserId();
    if (userId == null) return false;
    try {
      await _firestore.collection('users').doc(userId).update({
        // Add the new education to the list of educations in the user's document that in the userprofile map field in the firestore
        'profile.education': FieldValue.arrayUnion([education.toMap()]),
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> removeEducation(Education education) async {
    String? userId = getCurrentUserId();
    if (userId == null) return false;
    try {
      await _firestore.collection('users').doc(userId).update({
        // Remove the specified education from the list of educations in the user's document
        'profile.education': FieldValue.arrayRemove([education.toMap()]),
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }



  // i need to add a function to change the password of the authenticated user by sending an email to the user to reset the password
  Future<bool> changeUserPassword(String newPassword) async {
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;
      // Update the password
      await user!.updatePassword(newPassword);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
  Future<bool> updateEmailIfVerified(String newEmail) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    await user!.reload(); // Refresh user data to get the latest emailVerified status
    if (user.emailVerified) {
  final uid = user.uid;

      // Proceed with updating the email if the current email is verified
      await user.verifyBeforeUpdateEmail(newEmail);
      // Optionally, send a verification email for the new email
      await user.sendEmailVerification();
      await _firestore.collection('users').doc(uid).update({
        'email': newEmail,
      });
      return true;
    } else {
      print("Email is not verified. Cannot update email.");
      return false;
    }
  } catch (e) {
    print(e.toString());
    return false;
  }
}



Future<bool> reauthenticateAndDeleteUser(String email, String password) async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    print("No user signed in.");
    return false;
  }
  final uid = user.uid;
  // Create credential
  AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);
  try {
    // Re-authenticate
    await user.reauthenticateWithCredential(credential);
    await FirebaseFirestore.instance.collection('users').doc(uid).delete();
    // If re-authentication is successful, proceed to delete the user
    await user.delete();
    print("User account deleted successfully.");
    return true;
  } on FirebaseAuthException catch (e) {
    // Handle different errors here (e.g., wrong password)
    print("Error during re-authentication: ${e.code}");
    return false;
  }
}





}





/*
***************************important ***********************


  String? getCurrentUserId() {
    return _authenticationWebServices.getCurrentUser()?.uid;
  }

  or
  String userId = FirebaseAuth.instance.currentUser!.uid;


  
***************************important ***********************

*/


/*

Future<UserProfile?> getUserProfile(String userId) async {
  try {
    DocumentSnapshot userDoc = await _firestore.collection('users').doc(userId).get();
    if (userDoc.exists && userDoc.data().containsKey('profile')) {
      return UserProfile.fromMap(userDoc.data()['profile']);
    }
    return null;
  } catch (e) {
    print(e.toString());
    return null;
  }
}

Future<bool> updateUserProfileDirectly(String userId, UserProfile profile) async {
  try {
    await _firestore.collection('users').doc(userId).update({
      'profile': profile.toMap(),
    });
    return true;
  } catch (e) {
    print(e.toString());
    return false;
  }
}

//   // Fetch user profile information from Firestore
//   Future<UserProfile?> getUserProfileInfo() async {
//   String? userId = getCurrentUserId();
//   if (userId == null) return null;
//   try {
//     DocumentSnapshot userDoc = await _firestore.collection('users').doc(userId).get();
//     Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
//     // Directly construct and return the UserProfile object without checking if the profile data exists
//     return UserProfile.fromMap(data['profile']);
//   } catch (e) {
//     print(e.toString());
//     return null;
//   }
// }

//   // Update user profile information in Firestore
//   Future<bool> updateUserProfile(UserProfile profile) async {
//     String? userId = getCurrentUserId();
//     if (userId == null) return false;

//     try {
//       await _firestore.collection('users').doc(userId).update({
//         'profile': profile.toMap(),
//       });
//       return true;
//     } catch (e) {
//       print(e.toString());
//       return false;
//     }
//   }

 */
