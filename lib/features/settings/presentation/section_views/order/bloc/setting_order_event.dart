import 'package:equatable/equatable.dart';
import 'package:pos/features/settings/domain/entities/setting_order_entity.dart';

sealed class SettingOrderEvent extends Equatable {
  const SettingOrderEvent();

  @override
  List<Object?> get props => [];
}

final class LoadOrderSettings extends SettingOrderEvent {}

final class OrderSettingsChanged extends SettingOrderEvent {
  final SettingOrderEntity settings;

  const OrderSettingsChanged(this.settings);

  @override
  List<Object?> get props => [settings];
}
