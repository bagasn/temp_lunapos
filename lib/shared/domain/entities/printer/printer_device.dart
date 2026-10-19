class PrinterDevice {
  final String printerAddress;
  final String printerName;
  final String? vendorId;
  final String? productId;

  PrinterDevice({
    required this.printerAddress,
    required this.printerName,
    this.vendorId,
    this.productId,
  });
}
