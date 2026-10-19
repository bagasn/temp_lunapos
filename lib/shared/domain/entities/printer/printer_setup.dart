import 'package:flutter/foundation.dart';

enum SettingPrinterType {
  escpos;

  static SettingPrinterType? getByName(String name) {
    switch (name) {
      case 'escpos':
        return SettingPrinterType.escpos;
      default:
        return null;
    }
  }
}

extension SettingPrinterTypeExt on SettingPrinterType {
  String getDisplayName() {
    switch (this) {
      case SettingPrinterType.escpos:
        return 'ESCPOS';
      // case PrinterType.pdf:
      //   return 'PDF';
    }
  }
}

enum SettingPrinterModule {
  escposBluetooth,
  escposNetwork,
  escposUsb;

  static SettingPrinterModule? getByName(String? name) {
    switch (name) {
      case 'escposBluetooth':
        return SettingPrinterModule.escposBluetooth;
      case 'escposNetwork':
        return SettingPrinterModule.escposNetwork;
      case 'escposUsb':
        return SettingPrinterModule.escposUsb;
      default:
        return null;
    }
  }

  static List<SettingPrinterModule> getAvailableModule() {
    if (kIsWeb) {
      return [
        SettingPrinterModule.escposBluetooth,
        SettingPrinterModule.escposNetwork,
        SettingPrinterModule.escposUsb,
      ];
    } else {
      return [
        SettingPrinterModule.escposBluetooth,
        SettingPrinterModule.escposNetwork,
        SettingPrinterModule.escposUsb,
      ];
    }
  }
}

extension SettingPrinterModuleExt on SettingPrinterModule {
  String getDisplayName() {
    switch (this) {
      case SettingPrinterModule.escposBluetooth:
        return 'Bluetooth';
      case SettingPrinterModule.escposNetwork:
        return kIsWeb ? 'Network Bridge' : 'Network';
      case SettingPrinterModule.escposUsb:
        return 'USB';
    }
  }
}
