import 'package:equatable/equatable.dart';
import 'package:pos/features/auth/select_outlet/domain/entities/outlet_entity.dart';

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
  final List<OutletEntity> outlets;
  const LoginSuccess(this.outlets);
  @override
  List<Object?> get props => [outlets];
}

final class LoginFailure extends LoginState {
  final String message;
  const LoginFailure(this.message);
  @override
  List<Object?> get props => [message];
}
