import 'package:equatable/equatable.dart';

abstract class UploadPhotoState extends Equatable {
  @override
  List<Object> get props => [];
}

class UploadPhotoInitial extends UploadPhotoState {}

class UploadPhotoLoading extends UploadPhotoState {}

class UploadPhotoSuccess extends UploadPhotoState {
  final String photoUrl;

  UploadPhotoSuccess(this.photoUrl);

  @override
  List<Object> get props => [photoUrl];
}

class UploadPhotoFailure extends UploadPhotoState {
  final String error;

  UploadPhotoFailure(this.error);

  @override
  List<Object> get props => [error];
}
