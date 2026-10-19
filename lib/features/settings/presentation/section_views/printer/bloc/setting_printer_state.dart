// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'setting_printer_bloc.dart';

enum SettingPrinterStateView { fetching, success, failure }

class SettingPrinterState extends Equatable {
  final SettingPrinterStateView stateView;
  final List<SettingPrinterEntity> printers;
  final String? errorMessage;

  const SettingPrinterState({
    required this.stateView,
    required this.printers,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [stateView, errorMessage, ...printers];

  SettingPrinterState copyWith({
    SettingPrinterStateView? stateView,
    List<SettingPrinterEntity>? printers,
    String? errorMessage,
  }) {
    return SettingPrinterState(
      stateView: stateView ?? this.stateView,
      printers: printers ?? this.printers,
      errorMessage: errorMessage,
    );
  }
}
