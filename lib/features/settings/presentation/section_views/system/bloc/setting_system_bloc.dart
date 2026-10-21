import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/core/database/app_database_manager.dart';
import 'package:pos/core/di/injection_container.dart';
import 'package:pos/core/local_storage/outlet_preferences.dart';
import 'package:pos/core/local_storage/user_preferences.dart';
import 'package:pos/core/network/api_endpoints.dart';

part 'setting_system_event.dart';
part 'setting_system_state.dart';

@injectable
class SettingSystemBloc extends Bloc<SettingSystemEvent, SettingSystemState> {
  final ActiveOutletPreferences _outletPreferences;
  final ActiveUserPreferences _userPreferences;
  final AppDatabaseManager _dbManager;

  SettingSystemBloc(
    this._outletPreferences,
    this._userPreferences,
    this._dbManager,
  ) : super(const SettingSystemState()) {
    on<SettingSystemLoaded>(_onLoaded);
    on<SettingSystemChangeOutletConfirmed>(_onChangeOutletConfirmed);
  }

  Future<void> _onLoaded(
    SettingSystemLoaded event,
    Emitter<SettingSystemState> emit,
  ) async {
    final outletName = await _outletPreferences.outletName();
    final baseVersion = ApiEndpoints.appVersion;
    final version = Env.isDev ? '$baseVersion-dev' : baseVersion;

    emit(
      state.copyWith(
        outletName: (outletName != null && outletName.isNotEmpty)
            ? outletName
            : '-',
        appVersion: version,
      ),
    );
  }

  Future<void> _onChangeOutletConfirmed(
    SettingSystemChangeOutletConfirmed event,
    Emitter<SettingSystemState> emit,
  ) async {
    await _outletPreferences.clear();
    await _userPreferences.clear();
    await _dbManager.closeMainDatabase();
    emit(state.copyWith(isRedirectToSelectOutlet: true));
  }
}
