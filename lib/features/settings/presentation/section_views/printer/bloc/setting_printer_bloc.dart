import 'package:drift/drift.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/core/database/app_database_manager.dart';
import 'package:pos/features/settings/domain/entities/setting_printer_entity.dart';
import 'package:pos/shared/domain/entities/failure.dart';
import 'package:pos/shared/utilities/log_util.dart';

part 'setting_printer_event.dart';
part 'setting_printer_state.dart';

@injectable
class SettingPrinterBloc
    extends Bloc<SettingPrinterEvent, SettingPrinterState> {
  final AppDatabaseManager _dbManager;

  final List<SettingPrinterEntity> _printerAreas = [];

  SettingPrinterBloc(this._dbManager)
    : super(
        SettingPrinterState(
          stateView: SettingPrinterStateView.fetching,
          printers: [],
        ),
      ) {
    on<SettingPrinterInitStarted>(_onInitStarted);
    on<SettingPrinterStartPrint>(_onStartPrint);
    on<SettingPrinterFindDevice>(_onFindDevice);
  }

  void _onInitStarted(SettingPrinterInitStarted event, Emitter emit) async {
    emit(state.copyWith(stateView: SettingPrinterStateView.fetching));

    try {
      final dbMain = await _dbManager.mainDb;
      if (dbMain == null) {
        throw DatabaseFailure('Cannot find local database');
      }

      final getPrinterArea = dbMain.tablePrinterArea.select()
        ..orderBy([(u) => OrderingTerm.asc(u.sortOrder)]);
      final printerAreas = await getPrinterArea.get();

      _printerAreas.clear();
      for (final pArea in printerAreas) {
        _printerAreas.add(
          SettingPrinterEntity(
            id: pArea.id,
            label: pArea.name,
            printerConfig: null,
          ),
        );
      }

      emit(
        state.copyWith(
          stateView: SettingPrinterStateView.success,
          printers: _printerAreas,
        ),
      );
    } catch (error, stackTrace) {
      LogUtil.e(error.toString(), stackTrace: stackTrace);
      emit(
        state.copyWith(
          stateView: SettingPrinterStateView.failure,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  void _onStartPrint(SettingPrinterStartPrint event, Emitter emit) async {}

  void _onFindDevice(SettingPrinterFindDevice event, Emitter emit) async {}
}
