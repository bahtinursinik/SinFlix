import 'package:one_path/data/models/user_model.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserModel user;
  ProfileLoaded(this.user);
}

class ProfileFailure extends ProfileState {
  final String error;
  ProfileFailure(this.error);
}
