// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/shared/domain/entities/failure.dart';
import 'package:pos/shared/domain/entities/printer/printer_config.dart';
import 'package:pos/shared/domain/entities/printer/printer_setup.dart';
import 'package:thermal_printer_flutter/thermal_printer_flutter.dart';

/// Abstraction layer for thermal printer.
/// Implementation can be swapped when esc_pos_utils_plus is integrated.
@singleton
class PrinterService {
  final _thermalPrinterPlugin = ThermalPrinterFlutter();

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
}
