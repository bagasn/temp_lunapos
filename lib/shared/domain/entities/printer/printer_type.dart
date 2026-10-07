enum PrinterType { escpos, pdf }

extension PrinterTypeExt on PrinterType {
  String getDisplayName() {
    switch (this) {
      case PrinterType.escpos:
        return 'ESCPOS';
      case PrinterType.pdf:
        return 'PDF';
    }
  }
}

enum PrinterModule { ecspos_bluetooth, ecspos_usb, ecspos_network, pdf }

extension PrinterModuleExt on PrinterModule {
  String getDisplayName() {
    switch (this) {
      case PrinterModule.ecspos_bluetooth:
        return 'Bluetooth';
      case PrinterModule.ecspos_usb:
        return 'USB';
      case PrinterModule.ecspos_network:
        return 'Network';
      case PrinterModule.pdf:
        return 'PDF';
    }
  }
}
