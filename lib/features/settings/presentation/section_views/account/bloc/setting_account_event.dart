part of 'setting_account_bloc.dart';

sealed class SettingAccountEvent extends Equatable {
  const SettingAccountEvent();

  @override
  List<Object?> get props => [];
}

final class SettingAccountLoaded extends SettingAccountEvent {}

final class SettingAccountChangePinSubmitted extends SettingAccountEvent {
  final String oldPin;
  final String newPin;

  const SettingAccountChangePinSubmitted({
    required this.oldPin,
    required this.newPin,
  });

  @override
  List<Object?> get props => [oldPin, newPin];
}
