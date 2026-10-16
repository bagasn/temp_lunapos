// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pos/shared/utilities/number_formatter.dart';

class ThousandsDecimalFormatter extends TextInputFormatter {
  static const double _defaultMaxValue = 99_999_999_999.99;

  final double minValue;
  final double? maxValue;

  ThousandsDecimalFormatter({
    this.minValue = 0.0,
    this.maxValue = _defaultMaxValue,
  });

  final inputFormatter = NumberFormat.decimalPattern(
    NumberFormatter.currencyLocale,
  );

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text.replaceAll(RegExp(r'[^\d,]'), '');

    if (text.isEmpty) {
      final fixMinValue = inputFormatter.format(minValue.toDouble());
      return TextEditingValue(
        text: fixMinValue,
        selection: TextSelection.collapsed(offset: fixMinValue.length),
      );
    }

    if (text.startsWith(',')) {
      text = '0,';
      return TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    }

    int commaIndex = text.indexOf(',');
    if (commaIndex != -1) {
      final behindComma = text.substring(commaIndex + 1).replaceAll(',', '');
      if (behindComma.length > 2) {
        return oldValue;
      }

      text = text.substring(0, commaIndex + 1) + behindComma;
    }

    if (text.endsWith(',')) {
      final fixValue = newValue.text.substring(0, commaIndex + 2);
      return TextEditingValue(
        text: fixValue,
        selection: TextSelection.collapsed(offset: fixValue.length),
      );
    }

    double? value = inputFormatter.tryParse(text) as double?;
    if (value == null) {
      return oldValue;
    }

    final fixMax = maxValue ?? _defaultMaxValue;
    if (value > fixMax) {
      return oldValue;
    }

    String newText = inputFormatter.format(value);

    if (text.endsWith(',0') || text.endsWith(',00')) {
      newText += ',0';
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
