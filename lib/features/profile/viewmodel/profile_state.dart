part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}
class PasswordChanged extends ProfileState {}
class AccountDeleted extends ProfileState {}
class SignedOut extends ProfileState {}

class UserLoaded extends ProfileState {
  final UserModel user;
  UserLoaded(this.user);
}

class UserUpdated extends ProfileState {
  final UserModel user;
  UserUpdated(this.user);
}

class ProfileError extends ProfileState {
  final String errorMessage;
  ProfileError(this.errorMessage);
}
