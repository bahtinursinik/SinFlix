import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_path/data/datasources/remote/auth_repository.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc({required this.authRepository}) : super(LoginInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(LoginLoading());
      try {
        final response = await authRepository.login(
          event.email,
          event.password,
        );

        emit(LoginSuccess(response.token, response.user));
      } catch (e) {
        emit(LoginFailure(e.toString()));
      }
    });
  }
}
