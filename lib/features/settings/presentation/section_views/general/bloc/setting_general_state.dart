import 'package:equatable/equatable.dart';

sealed class SettingGeneralState extends Equatable {
  const SettingGeneralState();
  
  @override
  List<Object?> get props => [];
}

final class SettingGeneralInitial extends SettingGeneralState {}

final class SettingGeneralLoading extends SettingGeneralState {}

final class SettingGeneralLoaded extends SettingGeneralState {
  final bool isAutoLock;
  final String currentLocaleCode;

  const SettingGeneralLoaded({
    required this.isAutoLock,
    required this.currentLocaleCode,
  });

  @override
  List<Object?> get props => [isAutoLock, currentLocaleCode];

  SettingGeneralLoaded copyWith({
    bool? isAutoLock,
    String? currentLocaleCode,
  }) {
    return SettingGeneralLoaded(
      isAutoLock: isAutoLock ?? this.isAutoLock,
      currentLocaleCode: currentLocaleCode ?? this.currentLocaleCode,
    );
  }
}

final class SettingGeneralError extends SettingGeneralState {
  final String message;

  const SettingGeneralError(this.message);

  @override
  List<Object?> get props => [message];
}
