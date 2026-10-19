part of 'login_pos_user_bloc.dart';

sealed class LoginPosUserState extends Equatable {
  const LoginPosUserState();

  @override
  List<Object> get props => [];
}

final class LoginPosUserInitial extends LoginPosUserState {}

final class LoginPosUserLoading extends LoginPosUserState {}

final class LoginPosUserSuccess extends LoginPosUserState {}

final class LoginPosUserError extends LoginPosUserState {
  final String message;

  const LoginPosUserError(this.message);

  @override
  List<Object> get props => [message];
}
