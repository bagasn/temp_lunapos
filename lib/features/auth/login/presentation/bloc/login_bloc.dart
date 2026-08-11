import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/features/auth/login/domain/usecases/login_usecase.dart';
import 'package:pos/features/auth/login/presentation/bloc/login_event.dart';
import 'package:pos/features/auth/login/presentation/bloc/login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;

  LoginBloc(this._loginUseCase) : super(const LoginInitial()) {
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

    await loginResult.fold(
      (failure) async => emit(LoginFailure(failure.message)),
      (token) async {
        if (!token.hasCompany) {
          emit(const LoginFailure('Akun belum memiliki perusahaan/toko.'));
          return;
        }
      },
    );
  }
}
