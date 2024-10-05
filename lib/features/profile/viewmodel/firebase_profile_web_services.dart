import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
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
    return _authenticationWebServices.getCurrentUser()?.uid;
  }
  // Fetch user information from Firestore
  Future<User?> getUserInfo() async {
    String? userId = getCurrentUserId();
    if (userId == null) return null;
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userId).get();
      if (userDoc.exists) {
        return User.fromFirestore(userDoc);
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Update user information in Firestore
  Future<bool> updateUserInfo(User user) async {
    String? userId = getCurrentUserId();
    if (userId == null) return false;

    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .update(user.toFirestore());
      return true;
    } catch (e) {
      print(e.toString());
      return false;
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
