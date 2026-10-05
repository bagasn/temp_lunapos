import 'package:equatable/equatable.dart';
import 'package:pos/features/settings/domain/entities/setting_template_entity.dart';

sealed class SettingTemplateEvent extends Equatable {
  const SettingTemplateEvent();

  @override
  List<Object> get props => [];
}

class LoadTemplateSettings extends SettingTemplateEvent {}

class UpdateBillTemplate extends SettingTemplateEvent {
  final PrintoutTemplateItem bill;

  const UpdateBillTemplate(this.bill);

  @override
  List<Object> get props => [bill];
}

class UpdateReceiptTemplate extends SettingTemplateEvent {
  final PrintoutTemplateItem receipt;

  const UpdateReceiptTemplate(this.receipt);

  @override
  List<Object> get props => [receipt];
}
