part of 'setting_system_bloc.dart';

sealed class SettingSystemEvent extends Equatable {
  const SettingSystemEvent();

  @override
  List<Object> get props => [];
}

final class SettingSystemLoaded extends SettingSystemEvent {}

final class SettingSystemChangeOutletConfirmed extends SettingSystemEvent {}
