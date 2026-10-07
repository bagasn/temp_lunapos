part of 'setting_printer_bloc.dart';

sealed class SettingPrinterState extends Equatable {
  const SettingPrinterState();
  
  @override
  List<Object> get props => [];
}

final class SettingPrinterInitial extends SettingPrinterState {}
