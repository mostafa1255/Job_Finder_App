import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jop_finder_app/features/auth/data/model/user_model.dart';
import 'package:jop_finder_app/features/profile/viewmodel/firebase_profile_web_services.dart';
import 'package:url_launcher/url_launcher.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final FirebaseProfileWebServices _profileWebServices;

  ProfileCubit(this._profileWebServices) : super(ProfileInitial());

  Future<User> getUserInfo() async {
    emit(ProfileLoading());
    try {
      final userId = _profileWebServices.getCurrentUserId();
      if (userId == null) {
        emit(ProfileError("User not found"));
        return User(id: "", name: "error", email: ""); // Add return statement here
      }
      final user = await _profileWebServices.getUserInfo();
      if (user != null) {
        emit(UserLoaded(user));
        return user;
      } else {
        emit(ProfileError("User profile not found"));
        return User(id: "", name: "", email: ""); // Add return statement here
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
      return User(id: "", name: "", email: ""); // Add return statement here
    }
  }

  Future<void> updateUserInfo(User user) async {
    emit(ProfileLoading());
    try {
      final updateSuccess = await _profileWebServices.updateUserInfo(user);
      if (updateSuccess) {
        emit(UserLoaded(user));
      } else {
        emit(ProfileError("Failed to update user profile"));
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
    emit(ProfileLoading()); // Optional: Emit loading state before attempting to launch URL
    if (await canLaunch(url)) {
      await launch(url);
      emit(ProfileInitial()); // Optional: Emit initial state after launching URL successfully
    } else {
      print('Could not launch $url');
      emit(ProfileError("Could not launch URL")); // Emit error state if URL cannot be launched
    }
  }

}
