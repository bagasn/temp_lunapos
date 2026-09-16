import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'select_pos_user_event.dart';
part 'select_pos_user_state.dart';

class SelectPosUserBloc extends Bloc<SelectPosUserEvent, SelectPosUserState> {
  SelectPosUserBloc() : super(SelectPosUserInitial()) {
    on<SelectPosUserEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
