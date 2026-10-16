import 'package:drift/drift.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/core/database/app_database_manager.dart';
import 'package:pos/core/database/main_database.dart';
import 'package:pos/core/database/tables/main/printer_area.dart';
import 'package:pos/features/settings/domain/entities/setting_printer_entity.dart';
import 'package:pos/shared/domain/entities/failure.dart';
import 'package:pos/shared/services/printer/printer_service.dart';
import 'package:pos/shared/utilities/log_util.dart';
import 'package:uuid/v4.dart';

part 'setting_printer_event.dart';
part 'setting_printer_state.dart';

@injectable
class SettingPrinterBloc
    extends Bloc<SettingPrinterEvent, SettingPrinterState> {
  final AppDatabaseManager _dbManager;
  final PrinterService _printerService;

  final List<SettingPrinterEntity> _printerAreas = [];

  SettingPrinterBloc(this._dbManager, this._printerService)
    : super(
        SettingPrinterState(
          stateView: SettingPrinterStateView.fetching,
          printers: [],
        ),
      ) {
    on<SettingPrinterLoaded>(_onInitStarted);
    on<SettingPrinterNewAreaAdded>(_onNewAreaAdded);
  }

  void _onInitStarted(SettingPrinterLoaded event, Emitter emit) async {
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

  void _onNewAreaAdded(SettingPrinterNewAreaAdded event, Emitter emit) async {
    emit(state.copyWith(stateView: SettingPrinterStateView.fetching));
    await Future.delayed(Duration(seconds: 5));

    try {
      final dbMain = await _dbManager.mainDb;
      if (dbMain == null) {
        throw DatabaseFailure('Cannot find local database');
      }

      final tablePrinterArea = dbMain.tablePrinterArea;

      final stCheckExisting = tablePrinterArea.select()
        ..where((row) => row.name.equals(event.newAreaName));
      final resultCheckExisting = await stCheckExisting.getSingleOrNull();

      if (resultCheckExisting != null) {
        return emit(
          state.copyWith(
            errorMessage:
                'Nama printer area sudah digunakan, silakan masukan nama lain',
            stateView: SettingPrinterStateView.success,
          ),
        );
      }

      final columnSortOrderMax = tablePrinterArea.sortOrder.max();
      final stMaxSortOrder = dbMain.selectOnly(tablePrinterArea)
        ..addColumns([columnSortOrderMax]);
      final resultMaxSortOrder = await stMaxSortOrder
          .map((row) => row.read(columnSortOrderMax))
          .getSingleOrNull();

      final newSortOrder = (resultMaxSortOrder ?? 0) + 1;

      final resultInsert = await tablePrinterArea.insertOne(
        TablePrinterAreaCompanion.insert(
          id: UuidV4().generate(),
          name: event.newAreaName,
          type: PrinterAreaType.optional,
          sortOrder: newSortOrder,
        ),
      );

      if (resultInsert > 0) {
        add(SettingPrinterLoaded());
      }
    } catch (error, stackTrace) {
      LogUtil.e(error.toString(), stackTrace: stackTrace);
      emit(
        state.copyWith(
          stateView: SettingPrinterStateView.success,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
