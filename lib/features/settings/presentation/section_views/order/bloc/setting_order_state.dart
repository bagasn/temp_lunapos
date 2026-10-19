import 'package:equatable/equatable.dart';
import 'package:pos/features/settings/domain/entities/setting_order_entity.dart';

sealed class SettingOrderState extends Equatable {
  const SettingOrderState();

  @override
  List<Object?> get props => [];
}

final class SettingOrderInitial extends SettingOrderState {}

final class SettingOrderLoading extends SettingOrderState {}

final class SettingOrderLoaded extends SettingOrderState {
  final SettingOrderEntity settings;

  const SettingOrderLoaded(this.settings);

  @override
  List<Object?> get props => [settings];
}

final class SettingOrderError extends SettingOrderState {
  final String message;

  const SettingOrderError(this.message);

  @override
  List<Object?> get props => [message];
}
