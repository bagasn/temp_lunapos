import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/features/settings/domain/usecases/get_auto_lock_setting.dart';
import 'package:pos/features/settings/domain/usecases/update_auto_lock_setting.dart';
import 'package:pos/shared/domain/usecases/usecase.dart';
import 'package:pos/shared/services/language_service.dart';

import 'package:pos/features/settings/presentation/section_views/general/bloc/setting_general_event.dart';
import 'package:pos/features/settings/presentation/section_views/general/bloc/setting_general_state.dart';

@injectable
class SettingGeneralBloc extends Bloc<SettingGeneralEvent, SettingGeneralState> {
  final GetAutoLockSetting _getAutoLockSetting;
  final UpdateAutoLockSetting _updateAutoLockSetting;
  final LanguageService _languageService;

  SettingGeneralBloc(
    this._getAutoLockSetting,
    this._updateAutoLockSetting,
    this._languageService,
  ) : super(SettingGeneralInitial()) {
    on<LoadGeneralSettings>(_onLoadGeneralSettings);
    on<SettingGeneralAutoLockChanged>(_onAutoLockChanged);
    on<SettingGeneralLocaleChanged>(_onLocaleChanged);
  }

  Future<void> _onLoadGeneralSettings(
    LoadGeneralSettings event,
    Emitter<SettingGeneralState> emit,
  ) async {
    emit(SettingGeneralLoading());

    final autoLockResult = await _getAutoLockSetting(NoParams());
    
    // Get current locale code from service
    final currentLocaleCode = _languageService.currentLocale.languageCode;

    autoLockResult.fold(
      (failure) => emit(SettingGeneralError(failure.message)),
      (isAutoLock) => emit(SettingGeneralLoaded(
        isAutoLock: isAutoLock,
        currentLocaleCode: currentLocaleCode,
      )),
    );
  }

  Future<void> _onAutoLockChanged(
    SettingGeneralAutoLockChanged event,
    Emitter<SettingGeneralState> emit,
  ) async {
    final currentState = state;
    if (currentState is SettingGeneralLoaded) {
      // Optimistic update
      emit(currentState.copyWith(isAutoLock: event.isAutoLock));

      final result = await _updateAutoLockSetting(
        UpdateAutoLockParams(value: event.isAutoLock),
      );

      result.fold(
        (failure) {
          // Revert on failure
          emit(currentState);
          emit(SettingGeneralError(failure.message));
        },
        (_) {}, // Success, optimistic update remains
      );
    }
  }

  Future<void> _onLocaleChanged(
    SettingGeneralLocaleChanged event,
    Emitter<SettingGeneralState> emit,
  ) async {
    final currentState = state;
    if (currentState is SettingGeneralLoaded) {
      // Update the LanguageService
      final code = event.newLocaleCode == 'en' ? LanguageCode.en : LanguageCode.id;
      await _languageService.setLocale(code);

      // Update state
      emit(currentState.copyWith(currentLocaleCode: event.newLocaleCode));
    }
  }
}
