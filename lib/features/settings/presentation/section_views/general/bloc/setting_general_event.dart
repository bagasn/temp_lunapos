import 'package:equatable/equatable.dart';

sealed class SettingGeneralEvent extends Equatable {
  const SettingGeneralEvent();

  @override
  List<Object?> get props => [];
}

final class LoadGeneralSettings extends SettingGeneralEvent {}

final class SettingGeneralLocaleChanged extends SettingGeneralEvent {
  final String newLocaleCode; // e.g., 'id' or 'en'

  const SettingGeneralLocaleChanged({required this.newLocaleCode});

  @override
  List<Object?> get props => [newLocaleCode];
}

final class SettingGeneralAutoLockChanged extends SettingGeneralEvent {
  final bool isAutoLock;

  const SettingGeneralAutoLockChanged({required this.isAutoLock});

  @override
  List<Object?> get props => [isAutoLock];
}
