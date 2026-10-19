import 'package:equatable/equatable.dart';
import 'package:pos/features/auth/select_outlet/domain/entities/auth_outlet_entity.dart';
import 'package:pos/shared/domain/entities/failure.dart';

sealed class AuthOutletState extends Equatable {
  const AuthOutletState();
  @override
  List<Object?> get props => [];
}

final class AuthOutletInitial extends AuthOutletState {
  const AuthOutletInitial();
}

final class AuthOutletFetching extends AuthOutletState {
  const AuthOutletFetching();
}

final class AuthOutletDataState extends AuthOutletState {
  final List<AuthOutletEntity> outlets;

  const AuthOutletDataState({required this.outlets});

  @override
  List<Object?> get props => outlets;
}

final class AuthOutletTokenFetching extends AuthOutletState {
  const AuthOutletTokenFetching();
}

final class AuthOutletTokenSuccess extends AuthOutletState {
  const AuthOutletTokenSuccess();
}

final class AuthOutletFailure extends AuthOutletState {
  final Failure error;
  const AuthOutletFailure(this.error);
  @override
  List<Object?> get props => [error];
}
