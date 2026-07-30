import 'package:equatable/equatable.dart';
import 'package:pos/features/auth/select_outlet/domain/entities/outlet_entity.dart';

sealed class SelectOutletEvent extends Equatable {
  const SelectOutletEvent();
  @override
  List<Object?> get props => [];
}

final class OutletsLoaded extends SelectOutletEvent {
  final List<OutletEntity> outlets;
  const OutletsLoaded(this.outlets);
  @override
  List<Object?> get props => [outlets];
}

final class OutletSearchChanged extends SelectOutletEvent {
  final String keyword;
  const OutletSearchChanged(this.keyword);
  @override
  List<Object?> get props => [keyword];
}

final class OutletSelected extends SelectOutletEvent {
  final OutletEntity outlet;
  const OutletSelected(this.outlet);
  @override
  List<Object?> get props => [outlet];
}
