import 'package:drift/drift.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/core/database/app_database_manager.dart';
import 'package:pos/core/database/main_database.dart';
import 'package:pos/shared/data/models/dropdown_item_model.dart';
import 'package:pos/shared/domain/entities/failure.dart';
import 'package:pos/shared/domain/entities/printer/printer_config.dart';
import 'package:pos/shared/domain/entities/printer/printer_device.dart';
import 'package:pos/shared/domain/entities/printer/printer_setup.dart';
import 'package:pos/shared/services/printer/printer_service.dart';
import 'package:pos/shared/utilities/log_util.dart';
import 'package:uuid/v4.dart';

part 'printer_setup_state.dart';

@injectable
class PrinterSetupCubit extends Cubit<PrinterSetupState> {
  static PrinterSetupState _initState() {
    final printerType = DropdownItemModel(
      id: SettingPrinterType.escpos.name,
      display: SettingPrinterType.escpos.getDisplayName(),
    );
    final printerModules = SettingPrinterModule.getAvailableModule()
        .map(
          (element) => DropdownItemModel(
            id: element.name,
            display: element.getDisplayName(),
          ),
        )
        .toList();

    final paperSizes = [
      DropdownItemModel(id: '58', display: '58'),
      DropdownItemModel(id: '80', display: '80'),
    ];
    final selectedPaperSize = paperSizes.first;

    return PrinterSetupState(
      printerTypes: [printerType],
      selectedType: printerType,
      printerModules: printerModules,
      selectedModule: null,
      paperSizes: paperSizes,
      selectedPaperSize: selectedPaperSize,
      printerDevices: [],
      selectedDevice: null,
      feedAfterPrint: 0,
      isAutoCut: false,
      disconnectAfterPrint: true,
      copyPrint: 1,
      autoPrintOnPayment: false,
      viewState: PrinterSetupViewState.loading,
      btnSaveEnabled: true,
    );
  }

  final PrinterService _printerService;
  final AppDatabaseManager _dbManager;

  PrinterSetupCubit(this._printerService, this._dbManager)
    : super(_initState());

  void onChangeDropdownValue({
    DropdownItemModel? printerType,
    DropdownItemModel? printerModule,
    DropdownItemModel? paperSize,
  }) async {
    if (printerType != null) {
      emit(
        state.copyWith(
          selectedType: printerType,
          viewState: PrinterSetupViewState.data,
        ),
      );
    }
    if (printerModule != null) {
      emit(
        state.copyAndRemoveDevice(
          selectedModule: printerModule,
          viewState: PrinterSetupViewState.data,
        ),
      );
    }
    if (paperSize != null) {
      emit(
        state.copyWith(
          selectedPaperSize: paperSize,
          viewState: PrinterSetupViewState.data,
        ),
      );
    }

    LogUtil.d(state.toString());
  }

  void onChangeCheckboxValue({
    bool? isAutoCut,
    bool? isDisconnectAfterPrint,
    bool? isAutoPrintOnPayment,
  }) {
    if (isAutoCut != null) {
      emit(state.copyWith(isAutoCut: isAutoCut));
    }
    if (isDisconnectAfterPrint != null) {
      emit(state.copyWith(disconnectAfterPrint: isDisconnectAfterPrint));
    }
    if (isAutoPrintOnPayment != null) {
      emit(state.copyWith(autoPrintOnPayment: isAutoPrintOnPayment));
    }

    LogUtil.d(state.toString());
  }

  void onAddCopyValue(int valueAdd) {
    final current = state.copyPrint;
    final newValue = current + valueAdd;
    if (newValue >= 1 && newValue <= 100) {
      emit(state.copyWith(copyPrint: newValue));
    }

    LogUtil.d(state.toString());
  }

  void onRequestPrinterDevices() async {
    final selectedModule = state.selectedModule?.id ?? '';
    final printerModule = SettingPrinterModule.getByName(selectedModule);
    if (printerModule == null) {
      return;
    }

    final devices = await _printerService.getPrinterDevices(printerModule);
    if (devices.isEmpty) {
      return;
    }
    final device = devices.first;

    emit(state.copyWith(selectedDevice: device));
  }

  void onSavePrinterConfig({
    required String printerAreaId,
    required PrinterDevice? printerDevice,
  }) async {
    final printerModule = SettingPrinterModule.getByName(
      state.selectedModule?.id,
    );
    if (printerModule == null) return;

    if (printerDevice == null) {
      emit(state.copyWith(errorMessage: 'Device printer belum dipilih'));
      return;
    }

    emit(state.copyWith(viewState: PrinterSetupViewState.loading));

    final database = await _dbManager.mainDb;

    if (database == null) {
      throw DatabaseFailure('Local database not found');
    }

    try {
      final table = database.tablePrinter;

      final printerConfig = PrinterConfig(
        paperSize: state.selectedPaperSize.id,
        feedAfterPrint: state.feedAfterPrint,
        isAutoCut: state.isAutoCut,
        copyPrint: state.copyPrint,
        disconnectAfterPrint: state.disconnectAfterPrint,
        printerAddress: printerDevice.printerAddress,
        printerName: printerDevice.printerName,
      );

      final query = table.select()
        ..where((filter) => filter.printerAreaId.equals(printerAreaId));
      final existing = await query.getSingleOrNull();

      if (existing != null) {
        final row = existing
            .copyWith(
              printerType: state.selectedType.id,
              printerModule: printerModule.name,
              printerConfig: printerConfig.toJsonString(),
              updatedAt: Value(DateTime.now()),
            )
            .toCompanion(true);

        await table.insertOnConflictUpdate(row);
      } else {
        final row = TablePrinterCompanion.insert(
          id: UuidV4().generate(),
          printerAreaId: printerAreaId,
          printerType: state.selectedType.id,
          printerModule: printerModule.name,
          printerConfig: printerConfig.toJsonString(),
          createdAt: Value(DateTime.now()),
          updatedAt: Value(DateTime.now()),
        );

        await table.insertOne(row);
      }

      emit(state.copyWith(viewState: PrinterSetupViewState.printerSaved));
    } catch (error, stackTrace) {
      LogUtil.e(error.toString(), stackTrace: stackTrace);
      emit(
        state.copyWith(
          viewState: PrinterSetupViewState.data,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
