import 'package:equatable/equatable.dart';
import 'package:one_path/data/models/user_model.dart' show UserModel;

abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String token;
  final UserModel user;

  LoginSuccess(this.token, this.user);

  @override
  List<Object?> get props => [token, user];
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure(this.error);

  @override
  List<Object?> get props => [error];
}
