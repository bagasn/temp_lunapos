import 'package:pos/shared/domain/entities/failure.dart';

sealed class SyncState {
  const SyncState();
}

final class SyncInitial extends SyncState {
  const SyncInitial();
}

final class SyncInProgress extends SyncState {
  final bool isSilent;
  const SyncInProgress({this.isSilent = false});
}

final class SyncCompleted extends SyncState {
  const SyncCompleted();
}

final class SyncFailed extends SyncState {
  final Failure error;

  SyncFailed(this.error);
}
