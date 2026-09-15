import 'package:equatable/equatable.dart';

abstract class PosProductEvent extends Equatable {
  const PosProductEvent();

  @override
  List<Object?> get props => [];
}

/// Loads the next page of products (or initial load).
class FetchPosProducts extends PosProductEvent {
  final String? searchQuery;

  const FetchPosProducts({this.searchQuery});

  @override
  List<Object?> get props => [searchQuery];
}

/// Refreshes products from the beginning, resetting offset to 0.
class RefreshPosProducts extends PosProductEvent {
  final String? searchQuery;

  const RefreshPosProducts({this.searchQuery});

  @override
  List<Object?> get props => [searchQuery];
}
