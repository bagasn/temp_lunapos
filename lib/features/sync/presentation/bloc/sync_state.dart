import 'package:equatable/equatable.dart';

sealed class SyncState extends Equatable {
  const SyncState();
  @override
  List<Object?> get props => [];
}

final class SyncInitial extends SyncState {
  const SyncInitial();
}

final class SyncInProgress extends SyncState {
  const SyncInProgress();
}

final class SyncCompleted extends SyncState {
  const SyncCompleted();
}

final class SyncFailed extends SyncState {
  final String message;
  const SyncFailed(this.message);
  @override
  List<Object?> get props => [message];
}
