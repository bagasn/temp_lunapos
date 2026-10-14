import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/shared/data/models/dropdown_item_model.dart';
import 'package:pos/shared/domain/entities/printer/printer_config.dart';
import 'package:pos/shared/domain/entities/printer/printer_setup.dart';
import 'package:pos/shared/services/printer/printer_service.dart';
import 'package:pos/shared/utilities/log_util.dart';

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
      isLoading: false,
    );
  }

  final PrinterService _printerService;

  PrinterSetupCubit(this._printerService) : super(_initState());

  void onChangeDropdownValue({
    DropdownItemModel? printerType,
    DropdownItemModel? printerModule,
    DropdownItemModel? paperSize,
    DropdownItemModel? device,
  }) async {
    if (printerType != null) {
      emit(state.copyWith(selectedType: printerType, isLoading: false));
    }
    if (printerModule != null) {
      emit(state.copyWith(selectedModule: printerModule, isLoading: false));
    }
    if (paperSize != null) {
      emit(state.copyWith(selectedPaperSize: paperSize, isLoading: false));
    }
    // if (device != null) {
    //   emit(state.copyWith(selectedDevice: device));
    // }

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
}
