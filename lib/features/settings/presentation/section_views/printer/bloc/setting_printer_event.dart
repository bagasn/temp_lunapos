part of 'setting_printer_bloc.dart';

sealed class SettingPrinterEvent {
  const SettingPrinterEvent();
}

final class SettingPrinterLoaded extends SettingPrinterEvent {}

final class SettingPrinterNewAreaAdded extends SettingPrinterEvent {
  final String newAreaName;

  SettingPrinterNewAreaAdded(this.newAreaName);
}
