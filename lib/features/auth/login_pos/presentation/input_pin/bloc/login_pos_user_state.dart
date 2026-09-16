part of 'login_pos_user_bloc.dart';

sealed class LoginPosUserState extends Equatable {
  const LoginPosUserState();
  
  @override
  List<Object> get props => [];
}

final class LoginPosUserInitial extends LoginPosUserState {}
