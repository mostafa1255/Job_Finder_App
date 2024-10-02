import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jop_finder_app/features/auth/data/model/UserProfile_model.dart';
import 'package:jop_finder_app/features/auth/data/model/user_model.dart';
import 'package:jop_finder_app/features/profile/viewmodel/firebase_profile_web_services.dart';

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
        return User(id: "", name: "", email: "");
        
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
}