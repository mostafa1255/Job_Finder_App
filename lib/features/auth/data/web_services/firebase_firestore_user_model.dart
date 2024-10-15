import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jop_finder_app/features/auth/data/model/user_model.dart';

class FirebaseFirestoreUserModel {
  Future<void> saveUserToFirestore(UserModel user) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Check if the user with this UID already exists
      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(user.id).get();

      if (userDoc.exists) {
        print('User already exists in Firestore');
      } else {
        // Save user to Firestore if the user does not exist
        await firestore
            .collection('users')
            .doc(user.id)
            .set(user.toFirestore());
        print('User saved successfully');
      }
    } catch (e) {
      print('Failed to save user: $e');
    }
  }
}
