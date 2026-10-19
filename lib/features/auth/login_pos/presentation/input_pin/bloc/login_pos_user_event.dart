part of 'login_pos_user_bloc.dart';

sealed class LoginPosUserEvent extends Equatable {
  const LoginPosUserEvent();

  @override
  List<Object> get props => [];
}

final class VerifyPinEvent extends LoginPosUserEvent {
  final String userId;
  final String pin;

  const VerifyPinEvent({required this.userId, required this.pin});

  @override
  List<Object> get props => [userId, pin];
}
