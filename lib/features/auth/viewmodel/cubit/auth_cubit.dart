import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jop_finder_app/core/utils/app_router.dart';
import 'package:jop_finder_app/features/auth/data/web_services/firebase_authentication_web_services.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  FireBaseAuthenticationWebServices fireBaseAuthenticationWebServices =
      FireBaseAuthenticationWebServices();

  Future<void> signIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      var user = await fireBaseAuthenticationWebServices.signIn(
          email: email, password: password);
      if (user != null)
        GoRouter.of(context).pushReplacementNamed(AppRouter.homeScreen);
      emit(AuthLoaded());
    } catch (e) {
      emit(AuthError(errorMessage: e.toString()));
    }
  }

  Future<void> signUp(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      var user = await fireBaseAuthenticationWebServices.signUp(
          email: email, password: password);
      fireBaseAuthenticationWebServices.signOut();
      GoRouter.of(context).pushReplacementNamed(AppRouter.login);
      emit(AuthLoaded());
    } catch (e) {
      emit(AuthError(errorMessage: e.toString()));
    }
  }

  Future<void> signOut() async {
    try {
      await fireBaseAuthenticationWebServices.signOut();
      emit(AuthLoaded());
    } catch (e) {
      emit(AuthError(errorMessage: e.toString()));
    }
  }

  Future<void> resetPassword({required String email}) async {
    try {
      await fireBaseAuthenticationWebServices.resetPassword(email: email);
      emit(AuthLoaded());
    } catch (e) {
      emit(AuthError(errorMessage: e.toString()));
    }
  }
}
