import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/core/local_storage/session_manager.dart';
import 'package:pos/features/auth/login/domain/usecases/login_usecase.dart';
import 'package:pos/features/auth/login/presentation/bloc/login_event.dart';
import 'package:pos/features/auth/login/presentation/bloc/login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;
  final SessionManager _sessionManager;

  LoginBloc(this._loginUseCase, this._sessionManager)
    : super(const LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<LoginReset>((_, emit) => emit(const LoginInitial()));
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginLoading());

    final loginResult = await _loginUseCase(
      LoginParams(username: event.username, password: event.password),
    );

    await loginResult.fold((failure) async => emit(LoginFailure(failure)), (
      result,
    ) async {
      await _sessionManager.setupUserLogin(
        userAccessToken: result.accessToken,
        userRefreshToken: result.refreshToken,
      );

      emit(LoginSuccess());
    });
  }
}
