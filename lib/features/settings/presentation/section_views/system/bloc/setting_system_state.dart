part of 'setting_system_bloc.dart';

class SettingSystemState extends Equatable {
  final String outletName;
  final String appVersion;
  final bool isRedirectToSelectOutlet;

  const SettingSystemState({
    this.outletName = '-',
    this.appVersion = '',
    this.isRedirectToSelectOutlet = false,
  });

  SettingSystemState copyWith({
    String? outletName,
    String? appVersion,
    bool? isRedirectToSelectOutlet,
  }) {
    return SettingSystemState(
      outletName: outletName ?? this.outletName,
      appVersion: appVersion ?? this.appVersion,
      isRedirectToSelectOutlet:
          isRedirectToSelectOutlet ?? this.isRedirectToSelectOutlet,
    );
  }

  @override
  List<Object> get props => [outletName, appVersion, isRedirectToSelectOutlet];
}
