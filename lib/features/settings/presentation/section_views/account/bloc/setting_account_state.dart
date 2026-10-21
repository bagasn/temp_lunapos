part of 'setting_account_bloc.dart';

enum SettingAccountStatus { initial, loading, success, failure }

/// Why a change-PIN attempt failed. Mapped to a localized message in the UI.
enum SettingAccountError { userNotFound, oldPinInvalid, unknown }

class SettingAccountState extends Equatable {
  final SettingAccountStatus status;
  final String userName;
  final SettingAccountError? error;
  final String? errorDetail;

  const SettingAccountState({
    this.status = SettingAccountStatus.initial,
    this.userName = '-',
    this.error,
    this.errorDetail,
  });

  SettingAccountState copyWith({
    SettingAccountStatus? status,
    String? userName,
    SettingAccountError? error,
    String? errorDetail,
  }) {
    return SettingAccountState(
      status: status ?? this.status,
      userName: userName ?? this.userName,
      error: error,
      errorDetail: errorDetail,
    );
  }

  @override
  List<Object?> get props => [status, userName, error, errorDetail];
}
