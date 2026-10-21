import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/core/database/app_database_manager.dart';
import 'package:pos/core/database/main_database.dart';
import 'package:pos/core/local_storage/user_preferences.dart';
import 'package:pos/shared/utilities/log_util.dart';

part 'setting_account_event.dart';
part 'setting_account_state.dart';

@injectable
class SettingAccountBloc
    extends Bloc<SettingAccountEvent, SettingAccountState> {
  final ActiveUserPreferences _userPreferences;
  final AppDatabaseManager _dbManager;

  SettingAccountBloc(this._userPreferences, this._dbManager)
    : super(const SettingAccountState()) {
    on<SettingAccountLoaded>(_onLoaded);
    on<SettingAccountChangePinSubmitted>(_onChangePinSubmitted);
  }

  String _hash(String pin) => sha256.convert(utf8.encode(pin)).toString();

  Future<void> _onLoaded(
    SettingAccountLoaded event,
    Emitter<SettingAccountState> emit,
  ) async {
    final fullName = await _userPreferences.getUserFullName();
    final firstName = await _userPreferences.getUserFirstName();

    final name = (fullName != null && fullName.isNotEmpty)
        ? fullName
        : (firstName != null && firstName.isNotEmpty)
        ? firstName
        : '-';

    emit(state.copyWith(userName: name));
  }

  Future<void> _onChangePinSubmitted(
    SettingAccountChangePinSubmitted event,
    Emitter<SettingAccountState> emit,
  ) async {
    emit(state.copyWith(status: SettingAccountStatus.loading));

    try {
      final db = await _dbManager.mainDb;
      final userId = await _userPreferences.getUserId();

      if (db == null || userId == null || userId.isEmpty) {
        return emit(
          state.copyWith(
            status: SettingAccountStatus.failure,
            error: SettingAccountError.userNotFound,
          ),
        );
      }

      final user = await (db.select(
        db.tableUser,
      )..where((t) => t.id.equals(userId))).getSingleOrNull();

      if (user == null) {
        return emit(
          state.copyWith(
            status: SettingAccountStatus.failure,
            error: SettingAccountError.userNotFound,
          ),
        );
      }

      final storedPin = (user.pinNumber ?? '').toLowerCase();
      if (_hash(event.oldPin) != storedPin) {
        return emit(
          state.copyWith(
            status: SettingAccountStatus.failure,
            error: SettingAccountError.oldPinInvalid,
          ),
        );
      }

      await (db.update(db.tableUser)..where((t) => t.id.equals(userId))).write(
        TableUserCompanion(
          pinNumber: Value(_hash(event.newPin)),
          updatedAt: Value(DateTime.now()),
        ),
      );

      emit(state.copyWith(status: SettingAccountStatus.success));
    } catch (error, stackTrace) {
      LogUtil.e('Fail on change PIN', error: error, stackTrace: stackTrace);
      emit(
        state.copyWith(
          status: SettingAccountStatus.failure,
          error: SettingAccountError.unknown,
          errorDetail: error.toString(),
        ),
      );
    }
  }
}
