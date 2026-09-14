import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pos_order_event.dart';
part 'pos_order_state.dart';

class PosOrderBloc extends Bloc<PosOrderEvent, PosOrderState> {
  PosOrderBloc() : super(PosOrderInitial()) {
    on<PosOrderEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
