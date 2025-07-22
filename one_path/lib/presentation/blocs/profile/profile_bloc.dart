import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_path/core/services/logger_service.dart';
import 'package:one_path/data/datasources/remote/auth_repository.dart';
import 'package:one_path/presentation/blocs/profile/profile_event.dart';
import 'package:one_path/presentation/blocs/profile/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthRepository authRepository;

  ProfileBloc(this.authRepository) : super(ProfileInitial()) {
    on<ProfileRequested>((event, emit) async {
      LoggerService.logInfo(
        'ProfileRequested event alındı, token ile profil çekiliyor.',
      );

      emit(ProfileLoading());

      try {
        final user = await authRepository.fetchProfile(event.token);
        LoggerService.logInfo('Profil başarıyla yüklendi: userId=${user.id}');
        emit(ProfileLoaded(user));
      } catch (e) {
        LoggerService.logError('Profil yüklenirken hata oluştu', e);
        emit(ProfileFailure(e.toString()));
      }
    });
  }
}
