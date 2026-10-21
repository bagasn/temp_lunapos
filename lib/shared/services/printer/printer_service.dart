import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/core/database/app_database_manager.dart';
import 'package:pos/shared/domain/entities/failure.dart';
import 'package:pos/shared/domain/entities/printer/printer_config.dart';
import 'package:pos/shared/domain/entities/printer/printer_device.dart';
import 'package:pos/shared/domain/entities/printer/printer_setup.dart';
import 'package:pos/shared/services/printer/printout/testprint_printout.dart';
import 'package:pos/shared/utilities/log_util.dart';
import 'package:thermal_printer_flutter/thermal_printer_flutter.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

@singleton
class PrinterService {
  final _thermalPrinterPlugin = ThermalPrinterFlutter();

  final AppDatabaseManager _dbManager;

  PrinterService(this._dbManager);

  Future<List<PrinterDevice>> getPrinterDevices(
    SettingPrinterModule printerModule,
  ) async {
    if (kIsWeb) {
      final selectedDevice = await _requestDeviceOnWeb(printerModule);
      if (selectedDevice != null) {
        return [selectedDevice];
      }

      return [];
    } else {
      throw PrinterFailure(
        'Unsupport platform: currentlly only web platform support',
      );
    }
  }

  Future<PrinterDevice?> _requestDeviceOnWeb(
    SettingPrinterModule printerModule,
  ) async {
    PrinterType? printerType;
    switch (printerModule) {
      case SettingPrinterModule.escposBluetooth:
        printerType = PrinterType.bluetooth;
        break;
      case SettingPrinterModule.escposUsb:
        printerType = PrinterType.usb;
        break;
      default:
        throw PrinterFailure(
          'Unsupport selected printer module for requesting printer devices',
        );
    }

    final device = await _thermalPrinterPlugin.requestPrinter(
      printerType: printerType,
    );
    if (device == null) return null;

    String printerAddress;
    if (printerType == PrinterType.bluetooth) {
      printerAddress = device.bleAddress;
    } else if (printerType == PrinterType.usb) {
      printerAddress = device.usbAddress;
    } else {
      throw PrinterFailure(
        'Unsupport selected printer type for returning printer device',
      );
    }

    return PrinterDevice(
      printerAddress: printerAddress,
      printerName: device.name,
    );
  }

  /// Throw [PrinterFailure] on error.
  Future<void> printTest({
    required String printerAreaLabel,
    required SettingPrinterModule printerModule,
    required PrinterConfig printerConfig,
  }) async {
    final printout = TestprintPrintout();
    final printData = await printout.getPrintout(
      printerAreaLabel: printerAreaLabel,
      printerModule: printerModule,
      printerConfig: printerConfig,
    );

    switch (printerModule) {
      case SettingPrinterModule.escposNetwork:
        await _printViaBridge(printData, printerConfig.printerAddress);
        break;
      case SettingPrinterModule.escposBluetooth:
        final printer = Printer(
          type: PrinterType.bluetooth,
          bleAddress: printerConfig.printerAddress,
        );

        await _thermalPrinterPlugin.connect(printer: printer);
        _thermalPrinterPlugin.printBytes(bytes: printData, printer: printer);
        await _thermalPrinterPlugin.disconnect(printer: printer);
        break;
      case SettingPrinterModule.escposUsb:
        final printer = Printer(
          type: PrinterType.usb,
          usbAddress: printerConfig.printerAddress,
        );

        await _thermalPrinterPlugin.connect(printer: printer);
        _thermalPrinterPlugin.printBytes(bytes: printData, printer: printer);
        await _thermalPrinterPlugin.disconnect(printer: printer);
        break;
    }
  }

  Future<void> _printViaBridge(List<int> bytes, String ipAddress) async {
    try {
      String wsUrl = 'ws://localhost:8921';
      final channel = WebSocketChannel.connect(Uri.parse(wsUrl));

      final payload = jsonEncode({"ipAddress": ipAddress, "bytes": bytes});

      channel.sink.add(payload);

      await for (final message in channel.stream) {
        final data = jsonDecode(message);
        if (data['status'] != 'success') {
          final errMessage = data['message'] as String;
          await channel.sink.close();

          throw PrinterFailure(errMessage);
        }
        break;
      }

      await channel.sink.close();
    } catch (error, stackTrace) {
      LogUtil.e(
        'Web Socket Bridge error',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
