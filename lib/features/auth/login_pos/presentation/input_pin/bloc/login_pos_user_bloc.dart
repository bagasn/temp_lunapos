import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_pos_user_event.dart';
part 'login_pos_user_state.dart';

class LoginPosUserBloc extends Bloc<LoginPosUserEvent, LoginPosUserState> {
  LoginPosUserBloc() : super(LoginPosUserInitial()) {
    on<LoginPosUserEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
