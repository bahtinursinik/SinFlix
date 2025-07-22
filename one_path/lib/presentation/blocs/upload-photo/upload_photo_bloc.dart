import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_path/core/services/logger_service.dart';
import 'package:one_path/data/datasources/remote/auth_repository.dart';

import 'upload_photo_event.dart';
import 'upload_photo_state.dart';

class UploadPhotoBloc extends Bloc<UploadPhotoEvent, UploadPhotoState> {
  final AuthRepository authRepository;

  UploadPhotoBloc({required this.authRepository})
      : super(UploadPhotoInitial()) {
    on<UploadPhotoRequested>((event, emit) async {
      LoggerService.logInfo(
        'UploadPhotoRequested event alındı: filePath=${event.filePath}',
      );
      emit(UploadPhotoLoading());

      try {
        final photoUrl = await authRepository.uploadPhoto(
          event.token,
          event.filePath,
        );

        LoggerService.logInfo('Upload başarılı, photoUrl = $photoUrl');

        if (photoUrl.isEmpty) {
          LoggerService.logWarning('Upload sonrası photoUrl boş dönüyor!');
        }

        emit(UploadPhotoSuccess(photoUrl));
      } catch (e) {
        LoggerService.logError('Upload sırasında hata oluştu', e);
        emit(UploadPhotoFailure(e.toString()));
      }
    });

    on<UploadPhotoReset>((event, emit) {
      LoggerService.logInfo(
        'UploadPhotoReset event alındı, state sıfırlanıyor.',
      );
      emit(UploadPhotoInitial());
    });
  }
}
