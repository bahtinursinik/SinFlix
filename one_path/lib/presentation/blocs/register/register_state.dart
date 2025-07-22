import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterFailure extends RegisterState {
  final String message;
  final String? field; // Hangi alana ait hata (örnek: 'email', 'password')

  RegisterFailure(this.message, {this.field});

  @override
  List<Object?> get props => [message, field];
}

class RegisterException implements Exception {
  final String message;
  final String? field;

  RegisterException(this.message, {this.field});

  @override
  String toString() => message;
}
