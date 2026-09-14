part of 'pos_order_bloc.dart';

sealed class PosOrderState extends Equatable {
  const PosOrderState();
  
  @override
  List<Object> get props => [];
}

final class PosOrderInitial extends PosOrderState {}
