part of 'setting_printer_bloc.dart';

sealed class SettingPrinterEvent {
  const SettingPrinterEvent();
}

final class SettingPrinterStartPrint extends SettingPrinterEvent {}

final class SettingPrinterFindDevice extends SettingPrinterEvent {}
