import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/shared/utilities/log_util.dart';
import 'package:thermal_printer_flutter/thermal_printer_flutter.dart';

part 'setting_printer_event.dart';
part 'setting_printer_state.dart';

@injectable
class SettingPrinterBloc
    extends Bloc<SettingPrinterEvent, SettingPrinterState> {
  SettingPrinterBloc() : super(SettingPrinterInitial()) {
    on<SettingPrinterStartPrint>(_onStartPrint);
    on<SettingPrinterFindDevice>(_onFindDevice);
  }

  void _onStartPrint(SettingPrinterStartPrint event, Emitter emit) async {
    final printer = ThermalPrinterFlutter();
    // Web Bluetooth (BLE) is the same, with PrinterType.bluetooth:
    if (await printer.isWebBluetoothSupported()) {
      final ble = await printer.requestPrinter(
        printerType: PrinterType.bluetooth,
      );
    } else {}
  }

  void _onFindDevice(SettingPrinterFindDevice event, Emitter emit) async {
    LogUtil.d('Find Devices Triggered');

    try {
      final printer = ThermalPrinterFlutter();
      final devices = await printer.getPrinters(
        printerType: PrinterType.bluetooth,
      );
      final text = StringBuffer();
      for (final device in devices) {
        text.write(device.toString());
      }
      LogUtil.d(text.toString());
    } catch (error, stack) {
      LogUtil.e(error.toString(), stackTrace: stack);
    }

    //  if (await printer.isWebBluetoothSupported()) {
    //       final ble = await printer.requestPrinter(
    //         printerType: PrinterType.bluetooth,
    //       );

    //       LogUtil.d(ble?.toString());
    //     } else {}
  }
}
