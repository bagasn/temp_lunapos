import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:pos/features/settings/domain/usecases/get_template_settings.dart';
import 'package:pos/features/settings/domain/usecases/update_template_settings.dart';
import 'package:pos/features/settings/presentation/section_views/template/bloc/setting_template_event.dart';
import 'package:pos/features/settings/presentation/section_views/template/bloc/setting_template_state.dart';

@injectable
class SettingTemplateBloc extends Bloc<SettingTemplateEvent, SettingTemplateState> {
  final GetTemplateSettings _getTemplateSettings;
  final UpdateTemplateSettings _updateTemplateSettings;

  SettingTemplateBloc(
    this._getTemplateSettings,
    this._updateTemplateSettings,
  ) : super(SettingTemplateInitial()) {
    on<LoadTemplateSettings>(_onLoadTemplateSettings);
    on<UpdateBillTemplate>(_onUpdateBillTemplate);
    on<UpdateReceiptTemplate>(_onUpdateReceiptTemplate);
  }

  Future<void> _onLoadTemplateSettings(
    LoadTemplateSettings event,
    Emitter<SettingTemplateState> emit,
  ) async {
    emit(SettingTemplateLoading());
    final result = await _getTemplateSettings();
    result.fold(
      (failure) => emit(SettingTemplateError(failure.message)),
      (settings) => emit(SettingTemplateLoaded(settings: settings)),
    );
  }

  Future<void> _onUpdateBillTemplate(
    UpdateBillTemplate event,
    Emitter<SettingTemplateState> emit,
  ) async {
    if (state is SettingTemplateLoaded) {
      final currentState = state as SettingTemplateLoaded;
      final newSettings = currentState.settings.copyWith(bill: event.bill);
      
      // Optimistic update
      emit(SettingTemplateLoaded(settings: newSettings));
      
      final result = await _updateTemplateSettings(newSettings);
      result.fold(
        (failure) {
          // Revert on failure
          emit(SettingTemplateError(failure.message));
          emit(currentState);
        },
        (_) {},
      );
    }
  }

  Future<void> _onUpdateReceiptTemplate(
    UpdateReceiptTemplate event,
    Emitter<SettingTemplateState> emit,
  ) async {
    if (state is SettingTemplateLoaded) {
      final currentState = state as SettingTemplateLoaded;
      final newSettings = currentState.settings.copyWith(receipt: event.receipt);
      
      // Optimistic update
      emit(SettingTemplateLoaded(settings: newSettings));
      
      final result = await _updateTemplateSettings(newSettings);
      result.fold(
        (failure) {
          // Revert on failure
          emit(SettingTemplateError(failure.message));
          emit(currentState);
        },
        (_) {},
      );
    }
  }
}
