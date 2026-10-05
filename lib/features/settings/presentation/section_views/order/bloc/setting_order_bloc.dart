import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/features/settings/domain/usecases/get_order_settings.dart';
import 'package:pos/features/settings/domain/usecases/update_order_settings.dart';
import 'package:pos/features/settings/presentation/section_views/order/bloc/setting_order_event.dart';
import 'package:pos/features/settings/presentation/section_views/order/bloc/setting_order_state.dart';
import 'package:pos/shared/domain/usecases/usecase.dart';

@injectable
class SettingOrderBloc extends Bloc<SettingOrderEvent, SettingOrderState> {
  final GetOrderSettings _getOrderSettings;
  final UpdateOrderSettings _updateOrderSettings;

  SettingOrderBloc(
    this._getOrderSettings,
    this._updateOrderSettings,
  ) : super(SettingOrderInitial()) {
    on<LoadOrderSettings>(_onLoad);
    on<OrderSettingsChanged>(_onChanged);
  }

  Future<void> _onLoad(
    LoadOrderSettings event,
    Emitter<SettingOrderState> emit,
  ) async {
    emit(SettingOrderLoading());

    final result = await _getOrderSettings(NoParams());

    result.fold(
      (failure) => emit(SettingOrderError(failure.message)),
      (settings) => emit(SettingOrderLoaded(settings)),
    );
  }

  Future<void> _onChanged(
    OrderSettingsChanged event,
    Emitter<SettingOrderState> emit,
  ) async {
    final previous = state;

    // Optimistic update: apply UI changes immediately
    emit(SettingOrderLoaded(event.settings));

    final result = await _updateOrderSettings(
      UpdateOrderSettingsParams(settings: event.settings),
    );

    result.fold(
      (failure) {
        // Revert to previous state on failure
        emit(previous);
        emit(SettingOrderError(failure.message));
      },
      (_) {}, // success — optimistic state stays
    );
  }
}
