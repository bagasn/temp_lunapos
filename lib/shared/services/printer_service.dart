import 'package:injectable/injectable.dart';

/// Abstraction layer for thermal printer.
/// Implementation can be swapped when esc_pos_utils_plus is integrated.
@singleton
class PrinterService {
  Future<void> printBill({
    required String orderId,
    required List<Map<String, dynamic>> orderLines,
    required double total,
    String? outletName,
    String? notes,
  }) async {
    // TODO: Implement with esc_pos_utils_plus
    // Placeholder for future printer integration
    throw UnimplementedError('Printer not yet configured');
  }
}
