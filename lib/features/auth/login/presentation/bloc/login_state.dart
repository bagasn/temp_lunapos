import 'package:equatable/equatable.dart';
import 'package:pos/shared/domain/entities/failure.dart';

sealed class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object?> get props => [];
}

final class LoginInitial extends LoginState {
  const LoginInitial();
}

final class LoginLoading extends LoginState {
  const LoginLoading();
}

final class LoginSuccess extends LoginState {
  const LoginSuccess();
}

final class LoginFailure extends LoginState {
  final Failure error;
  const LoginFailure(this.error);
  @override
  List<Object?> get props => [error];
}
