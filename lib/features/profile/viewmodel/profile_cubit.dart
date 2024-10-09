import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jop_finder_app/features/auth/data/model/UserProfile_model.dart';
import 'package:jop_finder_app/features/auth/data/model/user_model.dart';
import 'package:jop_finder_app/features/profile/viewmodel/firebase_profile_web_services.dart';
import 'package:url_launcher/url_launcher.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final FirebaseProfileWebServices _profileWebServices;

  ProfileCubit(this._profileWebServices) : super(ProfileInitial());

  Future<UserModel> getUserInfo() async {
    emit(ProfileLoading());
    try {
      final userId = _profileWebServices.getCurrentUserId();
      if (userId == null) {
        emit(ProfileError("User not found BY ID"));
        return UserModel(
            id: "", name: "error", email: ""); // Add return statement here
      }
      final user = await _profileWebServices.getUserInfo();
      if (user != null) {
        emit(UserLoaded(user));
        return user;
      } else {
        emit(ProfileError("User profile not found "));
        return UserModel(
            id: "", name: "", email: ""); // Add return statement here
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
      return UserModel(
          id: "", name: "", email: ""); // Add return statement here
    }
  }

// i need a implement the pick image method that is in the profile_web_services.dart
  Future<void> pickImageAndUpdateUser() async {
    try {
      final image = await _profileWebServices.pickImage();
      if (image != null) {
        final success =
            await _profileWebServices.uploadImageAndUpdateUser(image);
        if (success == true) {
          final user = await _profileWebServices.getUserInfo();
          if (user != null) {
            emit(UserUpdated(user));
          } else {
            emit(ProfileError("Failed to fetch updated user info"));
          }
        } else {
          emit(ProfileError("Failed to upload image "));
          await Future.delayed(const Duration(seconds: 5));
          final user = await _profileWebServices.getUserInfo();
          if (user != null) {
            emit(UserUpdated(user));
          }
        }
      } else {
        emit(ProfileError("Failed to pick image"));
        final user = await _profileWebServices.getUserInfo();
        if (user != null) {
          emit(UserUpdated(user));
        }
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> uploadCVAndUpdateUser(FilePickerResult cvPdf) async {
    emit(ProfileLoading());
    try {
      final success = await _profileWebServices.uploadFileAndUpdateUser(cvPdf);
      if (success == true) {
        // Assuming you have a method to fetch the updated user info
        final user = await _profileWebServices.getUserInfo();
        if (user != null) {
          emit(UserUpdated(user)); // Emitting a state with the updated user
        } else {
          emit(ProfileError("Failed to fetch updated user info"));
        }
      } else {
        emit(ProfileError("Failed to upload CV and update user"));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> openPdf(String url) async {
    emit(
        ProfileLoading()); // Optional: Emit loading state before attempting to launch URL
    if (await canLaunch(url)) {
      await launch(url);
      final user = await _profileWebServices.getUserInfo();
      if (user != null) {
        emit(UserUpdated(user));
      }
      // Optional: Emit initial state after launching URL successfully
    } else {
      emit(ProfileError(
          "Could not launch URL")); // Emit error state if URL cannot be launched
    }
  }

  //i need to implement the update bio method that is in the profile_web_services.dart
  Future<void> updateBio(String bio) async {
    emit(ProfileLoading());
    try {
      final success = await _profileWebServices.updateBio(bio);
      if (success == true) {
        final user = await _profileWebServices.getUserInfo();
        if (user != null) {
          emit(UserUpdated(user));
        } else {
          emit(ProfileError("Failed to fetch updated user info"));
        }
      } else {
        emit(ProfileError("Failed to update bio"));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  //i need to implement the update name email phone method that is in the profile_web_services.dart
  Future<void> customUpdateToFirebase(String key, String value) async {
    emit(ProfileLoading());
    try {
      final success =
          await _profileWebServices.customUpdateToFirebase(key, value);
      if (success == true) {
        final user = await _profileWebServices.getUserInfo();
        if (user != null) {
          emit(UserUpdated(user));
        } else {
          emit(ProfileError("Failed to fetch updated user info"));
        }
      } else {
        emit(ProfileError("Failed to update name and phone number"));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  //i need to implement the customUpdateToFirebaseProfile method that is in the profile_web_services.dart
  Future<void> customUpdateToFirebaseProfile(String key, String value) async {
    emit(ProfileLoading());
    try {
      final success =
          await _profileWebServices.customUpdateToFirebaseProfile(key, value);
      if (success == true) {
        final user = await _profileWebServices.getUserInfo();
        if (user != null) {
          emit(UserUpdated(user));
        } else {
          emit(ProfileError("Failed to fetch updated user info"));
        }
      } else {
        emit(ProfileError("Failed to update visibility or job title"));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  //i need to implement the add education method that is in the profile_web_services.dart

  Future<void> addEducation(Education education) async {
    emit(ProfileLoading());
    try {
      final success = await _profileWebServices.addEducation(education);
      if (success == true) {
        final user = await _profileWebServices.getUserInfo();
        if (user != null) {
          emit(UserUpdated(user));
        } else {
          emit(ProfileError("Failed to fetch updated user info"));
        }
      } else {
        emit(ProfileError("Failed to add education"));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> removeEducation(Education education) async {
    emit(ProfileLoading());
    try {
      final success = await _profileWebServices.removeEducation(education);
      if (success == true) {
        final user = await _profileWebServices.getUserInfo();
        if (user != null) {
          emit(UserUpdated(user)); // Update the UI with the new user data
        } else {
          emit(ProfileError("Failed to fetch updated user info"));
        }
      } else {
        emit(ProfileError("Failed to remove education"));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

//i want to implement the changeUserPassword from the firebase profile web services
  Future<void> changeUserPassword(String password) async {
    emit(ProfileLoading());
    try {
      final success = await _profileWebServices.changeUserPassword(password);
      if (success == true) {
        emit(PasswordChanged());
      } else {
        emit(ProfileError("Failed to change password"));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  //i want to implement the updateEmailIfVerified from the firebase profile web services
  Future<void> updateEmailIfVerified(String email) async {
    emit(ProfileLoading());
    try {
      final success = await _profileWebServices.updateEmailIfVerified(email);
      if (success == true) {
        final user = await _profileWebServices.getUserInfo();
        if (user != null) {
          emit(UserUpdated(user));
        } else {
          emit(ProfileError("Failed to fetch updated user info"));
        }
      } else {
        emit(ProfileError("Failed to update email"));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
  //i want to implement the reauthenticateAndDeleteUser method from the firebase profile web services

  Future<bool> reauthenticateAndDeleteUser(
      String email, String password) async {
    emit(ProfileLoading());
    try {
      final success = await _profileWebServices.reauthenticateAndDeleteUser(
          email, password);
      if (success == true) {
        emit(AccountDeleted());
        return true;
      } else {
        emit(ProfileError("Failed to delete user"));
        return false;
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
      return false;
    }
  }
}
