// ignore_for_file: constant_identifier_names

import 'package:injectable/injectable.dart';

/// Abstraction layer for thermal printer.
/// Implementation can be swapped when esc_pos_utils_plus is integrated.
@singleton
class PrinterService {
  static const int PAPER_SIZE_58 = 58;
  static const int PAPER_SIZE_80 = 80;
}
