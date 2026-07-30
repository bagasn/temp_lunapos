import 'package:equatable/equatable.dart';
import 'package:pos/features/auth/select_outlet/domain/entities/outlet_entity.dart';

sealed class SelectOutletState extends Equatable {
  const SelectOutletState();
  @override
  List<Object?> get props => [];
}

final class SelectOutletInitial extends SelectOutletState {
  const SelectOutletInitial();
}

final class SelectOutletLoaded extends SelectOutletState {
  final List<OutletEntity> allOutlets;
  final List<OutletEntity> filteredOutlets;
  final String keyword;

  const SelectOutletLoaded({
    required this.allOutlets,
    required this.filteredOutlets,
    this.keyword = '',
  });

  @override
  List<Object?> get props => [allOutlets, filteredOutlets, keyword];
}

final class SelectOutletSelecting extends SelectOutletState {
  const SelectOutletSelecting();
}

final class SelectOutletSuccess extends SelectOutletState {
  const SelectOutletSuccess();
}

final class SelectOutletFailure extends SelectOutletState {
  final String message;
  const SelectOutletFailure(this.message);
  @override
  List<Object?> get props => [message];
}
