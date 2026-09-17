import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/core/database/app_database_manager.dart';
import 'package:pos/core/local_storage/session_manager.dart';

part 'login_pos_user_event.dart';
part 'login_pos_user_state.dart';

@injectable
class LoginPosUserBloc extends Bloc<LoginPosUserEvent, LoginPosUserState> {
  final AppDatabaseManager _databaseManager;
  final SessionManager _sessionManager;

  LoginPosUserBloc(this._databaseManager, this._sessionManager)
      : super(LoginPosUserInitial()) {
    on<VerifyPinEvent>(_onVerifyPin);
  }

  Future<void> _onVerifyPin(
    VerifyPinEvent event,
    Emitter<LoginPosUserState> emit,
  ) async {
    emit(LoginPosUserLoading());

    try {
      final db = await _databaseManager.mainDb;
      if (db == null) {
        return emit(const LoginPosUserError('Database tidak tersedia.'));
      }

      // Fetch user from database
      final userList = await db.managers.tableUser
          .filter((f) => f.id(event.userId))
          .get();

      if (userList.isEmpty) {
        return emit(const LoginPosUserError('User tidak ditemukan.'));
      }

      final user = userList.first;

      if (user.pinNumber == null || user.pinNumber!.isEmpty) {
        return emit(const LoginPosUserError('User tidak memiliki PIN.'));
      }

      // Hash the entered PIN with SHA-256 and compare
      final hashedPin = sha256.convert(utf8.encode(event.pin)).toString();

      if (hashedPin != user.pinNumber) {
        return emit(const LoginPosUserError('PIN salah. Coba lagi.'));
      }

      // Save active user to SharedPreferences
      await _sessionManager.posUser.setActiveUser(
        userId: user.id,
        userFirstName: user.firstName ?? '',
        userLastName: user.lastName ?? '',
        userFullName: user.fullName ?? user.firstName ?? '',
      );

      emit(LoginPosUserSuccess());
    } catch (e) {
      emit(LoginPosUserError(e.toString()));
    }
  }
}
