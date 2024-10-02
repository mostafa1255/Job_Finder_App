part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}
class ProfileLoading extends ProfileState {}


class UserLoaded extends ProfileState {
  final User user;
  UserLoaded(this.user);
}

class UserUpdated extends ProfileState {
  final User user;
  UserUpdated(this.user);
}


class ProfileError extends ProfileState {
  final String errorMessage;
  ProfileError(this.errorMessage);
}