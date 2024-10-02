import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:jop_finder_app/features/auth/data/model/user_model.dart';
import 'package:jop_finder_app/features/auth/data/model/UserProfile_model.dart';
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

  Future<bool> setUserProfileIfNotExists(UserProfile profile) async {
    String? userId = getCurrentUserId();
    if (userId == null) return false;

    try {
      DocumentReference userDocRef = _firestore.collection('users').doc(userId);
      DocumentSnapshot userDoc = await userDocRef.get();
      if (!userDoc.exists ||
          !(userDoc.data() as Map<String, dynamic>).containsKey('profile')) {
        // The user document doesn't exist or doesn't have a 'profile' key
        await userDocRef
            .set({'profile': profile.toMap()}, SetOptions(merge: true));
        return true;
      }
      // Profile already exists
      return false;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  // Fetch user profile information from Firestore
  Future<UserProfile?> getUserProfileInfo() async {
    String? userId = getCurrentUserId();
    if (userId == null) return null;
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userId).get();
      if (userDoc.exists) {
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
        // Check if the profile data exists
        if (data.containsKey('profile')) {
          // Construct and return the UserProfile object
          return UserProfile.fromMap(data['profile']);
        }
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Update user profile information in Firestore
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

  // Method to pick a PDF file
  Future<File?> pickPDF() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (result != null) {
        return File(result.files.single.path!);
      } else {
        // User canceled the picker
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Method to upload a file to Firebase Storage
  Future<String?> uploadFile(File file, String path) async {
    try {
      Reference ref = FirebaseStorage.instance.ref().child('CVs/$path');
      UploadTask uploadTask = ref.putFile(file);
      final snapshot = await uploadTask.whenComplete(() {});
      final urlDownload = await snapshot.ref.getDownloadURL();
      return urlDownload;
    } catch (e) {
      print(e);
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
      print(e);
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
      print(e);
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
  String? getCurrentUserId() {
    return _authenticationWebServices.getCurrentUser()?.uid;
  }
*/