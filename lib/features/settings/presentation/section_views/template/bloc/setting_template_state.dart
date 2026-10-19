import 'package:equatable/equatable.dart';
import 'package:pos/features/settings/domain/entities/setting_template_entity.dart';

sealed class SettingTemplateState extends Equatable {
  const SettingTemplateState();

  @override
  List<Object?> get props => [];
}

class SettingTemplateInitial extends SettingTemplateState {}

class SettingTemplateLoading extends SettingTemplateState {}

class SettingTemplateLoaded extends SettingTemplateState {
  final SettingTemplateEntity settings;

  const SettingTemplateLoaded({required this.settings});

  @override
  List<Object?> get props => [settings];
}

class SettingTemplateError extends SettingTemplateState {
  final String message;

  const SettingTemplateError(this.message);

  @override
  List<Object?> get props => [message];
}
