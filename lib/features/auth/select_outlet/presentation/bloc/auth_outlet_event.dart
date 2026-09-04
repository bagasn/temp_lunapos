import 'package:equatable/equatable.dart';
import 'package:pos/features/auth/select_outlet/domain/entities/auth_outlet_entity.dart';

sealed class AuthOutletEvent extends Equatable {
  const AuthOutletEvent();
  @override
  List<Object?> get props => [];
}

final class AuthOutletFetchStarted extends AuthOutletEvent {}

final class AuthOutletsLoaded extends AuthOutletEvent {
  const AuthOutletsLoaded();

  @override
  List<Object?> get props => [];
}

final class AuthOutletSearchChanged extends AuthOutletEvent {
  final String keyword;
  const AuthOutletSearchChanged(this.keyword);
  @override
  List<Object?> get props => [keyword];
}

final class AuthOutletSelected extends AuthOutletEvent {
  final AuthOutletEntity outlet;
  const AuthOutletSelected(this.outlet);
  @override
  List<Object?> get props => [outlet];
}
