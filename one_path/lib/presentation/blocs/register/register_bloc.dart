import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_path/core/services/logger_service.dart';
import 'package:one_path/data/datasources/remote/auth_repository.dart';

import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepository;

  RegisterBloc({required this.authRepository}) : super(RegisterInitial()) {
    on<RegisterSubmitted>((event, emit) async {
      LoggerService.logInfo(
        'RegisterSubmitted event alındı: email=${event.email}, name=${event.name}',
      );
      emit(RegisterLoading());

      try {
        await authRepository.register(event.name, event.email, event.password);
        LoggerService.logInfo('Kayıt başarılı: email=${event.email}');
        emit(RegisterSuccess());
      } on RegisterException catch (e) {
        LoggerService.logError('Kayıt hatası: ${e.message}', e);
        emit(RegisterFailure(e.message, field: e.field));
      } catch (e) {
        LoggerService.logError('Bilinmeyen kayıt hatası', e);
        emit(RegisterFailure("Bilinmeyen bir hata oluştu"));
      }
    });
  }
}
