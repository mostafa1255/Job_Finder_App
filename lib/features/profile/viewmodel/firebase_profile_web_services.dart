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
    return FirebaseAuth.instance.currentUser!.uid;
  }

  // Fetch user information from Firestore
  Future<UserModel?> getUserInfo() async {
    String? userId = getCurrentUserId();
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
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userId).get();
      String? currentImageUrl = userDoc['profileImageUrl'];

      // Delete the current image from Firebase Storage if it exists
      if (currentImageUrl != null && currentImageUrl.isNotEmpty) {
        String currentImageFileName =
            Uri.parse(currentImageUrl).pathSegments.last;
        await FirebaseStorage.instance
            .ref()
            .child(currentImageFileName)
            .delete();
      }
      // Upload image to Firebase Storage
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref =
          FirebaseStorage.instance.ref().child('user_images/$userId/$fileName');
      UploadTask uploadTask = ref.putFile(imageFile);
      final snapshot = await uploadTask.whenComplete(() {});
      final imageUrl = await snapshot.ref.getDownloadURL();

      // Update user's imageUrl in Firestore
      await _firestore.collection('users').doc(userId).update({
        'profileImageUrl': imageUrl,
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

//  pickFile method
  Future<bool?> uploadFileAndUpdateUser(FilePickerResult cvPdf) async {
    String? userId = getCurrentUserId();
    if (userId == null) return false;
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userId).get();
      String? currentCvUrl = userDoc['cvUrl'];
      // Delete the current CV from Firebase Storage if it exists
      if (currentCvUrl != null && currentCvUrl.isNotEmpty) {
        String currentCvFileName = Uri.parse(currentCvUrl).pathSegments.last;
        await FirebaseStorage.instance.ref().child(currentCvFileName).delete();
      }
      String fileName =
          "${DateTime.now().millisecondsSinceEpoch.toString()}.pdf";
      Reference ref =
          FirebaseStorage.instance.ref().child('CVs/$userId/$fileName');
      UploadTask uploadTask;
      // Check if running on web
      if (kIsWeb) {
        final bytes = cvPdf.files.first.bytes;
        if (bytes == null) throw Exception("File bytes are null");
        uploadTask = ref.putData(
            bytes, SettableMetadata(contentType: 'application/pdf'));
      } else {
        File file = File(cvPdf.files.single.path!);
        uploadTask =
            ref.putFile(file, SettableMetadata(contentType: 'application/pdf'));
      }
      final snapshot = await uploadTask.whenComplete(() {});
      final cvUrl = await snapshot.ref.getDownloadURL();
      await _firestore.collection('users').doc(userId).update({
        'cvUrl': cvUrl,
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

//  openPdf method
  Future<void> openPdf(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

//update the bio in the firestore
  Future<bool> updateBio(String bio) async {
    String? userId = getCurrentUserId();
    if (userId == null) return false;
    try {
      await _firestore.collection('users').doc(userId).update({
        'profile.bio': bio,
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

//update cv ,email and phone number in the firestore
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

//update the status and and job title in the firestore
  Future<bool> customUpdateToFirebaseProfile(String key, String value) async {
    String? userId = getCurrentUserId();
    if (userId == null) return false;
    try {
      await _firestore.collection('users').doc(userId).update({
        'profile.$key': value,
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

//add an education 
  Future<bool> addEducation(Education education) async {
    String? userId = getCurrentUserId();
    if (userId == null) return false;
    try {
      await _firestore.collection('users').doc(userId).update({
        'profile.education': FieldValue.arrayUnion([education.toMap()]),
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

//remove an education
  Future<bool> removeEducation(Education education) async {
    String? userId = getCurrentUserId();
    if (userId == null) return false;
    try {
      await _firestore.collection('users').doc(userId).update({
        'profile.education': FieldValue.arrayRemove([education.toMap()]),
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

//change the user password
  Future<bool> changeUserPassword(
      String currentEmail, String currentPassword, String newPassword) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      AuthCredential credential = EmailAuthProvider.credential(
          email: currentEmail, password: currentPassword);
      await user!.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

//update the user email
  Future<bool> updateEmail(
      String currentEmail, String currentPassword, String newEmail) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      final uid = user!.uid;
      AuthCredential credential = EmailAuthProvider.credential(
          email: currentEmail, password: currentPassword);
      await user.reauthenticateWithCredential(credential);
      await user.updateEmail(newEmail);
      await _firestore.collection('users').doc(uid).update({
        'email': newEmail,
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

//sign out the user
  Future<bool> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

//delete the user account
  Future<bool> reauthenticateAndDeleteUser(
      String email, String password) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("No user signed in.");
      return false;
    }
    final uid = user.uid;
    AuthCredential credential =
        EmailAuthProvider.credential(email: email, password: password);
    try {
      await user.reauthenticateWithCredential(credential);
      await FirebaseFirestore.instance.collection('users').doc(uid).delete();
      await user.delete();
      print("User account deleted successfully.");
      return true;
    } on FirebaseAuthException catch (e) {
      print("Error during re-authentication: ${e.code}");
      return false;
    }
  }

//update the user profile (for null value)
  Future<bool> updateUserProfile(UserProfile profile) async {
    String? userId = getCurrentUserId();
    if (userId == null) return false;

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
}
