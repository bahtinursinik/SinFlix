import 'package:equatable/equatable.dart';

abstract class UploadPhotoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UploadPhotoRequested extends UploadPhotoEvent {
  final String token;
  final String filePath;

  UploadPhotoRequested({required this.token, required this.filePath});

  @override
  List<Object> get props => [token, filePath];
}

class UploadPhotoReset extends UploadPhotoEvent {}
