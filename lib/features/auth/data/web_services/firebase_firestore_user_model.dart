import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jop_finder_app/features/auth/data/model/user_model.dart';

class FirebaseFirestoreUserModel {
  Future<void> saveUserToFirestore(UserModel user) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Save user to Firestore
      await firestore.collection('users').doc(user.id).set(user.toFirestore());
      print('User saved successfully');
    } catch (e) {
      print('Failed to save user: $e');
    }
  }
}
