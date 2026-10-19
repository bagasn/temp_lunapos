import 'package:pos/features/settings/domain/entities/setting_template_entity.dart';
import 'package:pos/features/settings/domain/repositories/settings_repository.dart';
import 'package:pos/shared/domain/entities/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetTemplateSettings {
  final SettingsRepository repository;

  GetTemplateSettings(this.repository);

  Future<Either<Failure, SettingTemplateEntity>> call() async {
    return await repository.getTemplateSettings();
  }
}
