import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jop_finder_app/core/utils/app_router.dart';
import 'package:jop_finder_app/features/auth/data/web_services/firebase_authentication_web_services.dart';
import 'package:jop_finder_app/features/auth/data/web_services/google_authentication_web_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final FireBaseAuthenticationWebServices fireBaseAuthenticationWebServices =
      FireBaseAuthenticationWebServices();
  final GoogleAuthenticationWebServices googleAuthenticationWebServices =
      GoogleAuthenticationWebServices();

  // Sign In
  Future<void> signIn({
    required String email,
    required String password,
    required BuildContext context,
    bool rememberMe = false, // Add rememberMe as a parameter
  }) async {
    emit(AuthLoading());
    try {
      var result = await fireBaseAuthenticationWebServices.signIn(
        email: email,
        password: password,
      );

      if (result == "User signed in successfully") {
        if (rememberMe) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true); // Store login status
          await prefs.setString('email', email); // Store email
          await prefs.setString(
              'password', password); // Optionally store password
        }

        GoRouter.of(context).pushReplacementNamed(AppRouter.homeScreen);
        emit(AuthLoaded());
      } else {
        emit(AuthError(errorMessage: result ?? "Failed to sign in"));
      }
    } catch (e) {
      emit(AuthError(errorMessage: e.toString()));
    }
  }

  // Sign Up
  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
    required BuildContext context,
  }) async {
    emit(AuthLoading());
    try {
      var result = await fireBaseAuthenticationWebServices.signUp(
          email: email, password: password, fullName: fullName);

      if (result == "User signed up successfully") {
        await fireBaseAuthenticationWebServices.signOut();
        GoRouter.of(context).pushReplacementNamed(AppRouter.login);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(result.toString())));
        emit(AuthLoaded());
      } else {
        emit(AuthError(errorMessage: result ?? "Failed to sign up"));
      }
    } catch (e) {
      emit(AuthError(errorMessage: e.toString()));
    }
  }

  // Sign Out
  Future<void> signOut() async {
    emit(AuthLoading());
    try {
      await fireBaseAuthenticationWebServices.signOut();
      emit(AuthLoaded());
    } catch (e) {
      emit(AuthError(errorMessage: "Failed to sign out: ${e.toString()}"));
    }
  }

  // Reset Password
  Future<void> resetPassword(
      {required String email, required BuildContext context}) async {
    emit(AuthLoading());
    try {
      var result =
          await fireBaseAuthenticationWebServices.resetPassword(email: email);

      if (result == "Password reset email sent") {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Email password reset link sent!')));
        GoRouter.of(context).pushReplacementNamed(AppRouter.login);
        emit(AuthLoaded());
      } else {
        emit(AuthError(errorMessage: result ?? "Failed to send reset email"));
      }
    } catch (e) {
      emit(AuthError(errorMessage: e.toString()));
    }
  }

  // Sign In with Google
  Future<void> signInWithGoogle(BuildContext context) async {
    emit(AuthLoading());
    try {
      var result = await googleAuthenticationWebServices.signInWithGoogle();
      if (result != null &&
          result == "User signed in successfully with Google") {
        GoRouter.of(context).pushReplacementNamed(AppRouter.homeScreen);
        emit(AuthLoaded());
      } else {
        emit(AuthError(errorMessage: result ?? "Unknown error occurred"));
      }
    } catch (e) {
      emit(AuthError(errorMessage: e.toString()));
    }
  }
}
