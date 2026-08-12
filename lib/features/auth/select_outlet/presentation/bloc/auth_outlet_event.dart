import 'package:equatable/equatable.dart';
import 'package:pos/features/auth/select_outlet/domain/entities/auth_outlet_entity.dart';

sealed class AuthOutletEvent extends Equatable {
  const AuthOutletEvent();
  @override
  List<Object?> get props => [];
}

final class AuthOutletFetchStarted extends AuthOutletEvent {}

final class AuthOutletsLoaded extends AuthOutletEvent {
  final List<AuthOutletEntity> outlets;
  const AuthOutletsLoaded(this.outlets);
  @override
  List<Object?> get props => [outlets];
}

final class OutletSearchChanged extends AuthOutletEvent {
  final String keyword;
  const OutletSearchChanged(this.keyword);
  @override
  List<Object?> get props => [keyword];
}

final class OutletSelected extends AuthOutletEvent {
  final AuthOutletEntity outlet;
  const OutletSelected(this.outlet);
  @override
  List<Object?> get props => [outlet];
}
