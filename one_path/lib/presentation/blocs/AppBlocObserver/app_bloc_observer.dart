import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_path/core/services/logger_service.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    LoggerService.logInfo('Event: ${bloc.runtimeType} → $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    LoggerService.logInfo(
      'State transition: ${bloc.runtimeType} → $transition',
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    LoggerService.logError('Hata: ${bloc.runtimeType}', error);
    super.onError(bloc, error, stackTrace);
  }
}
