sealed class SyncEvent {
  const SyncEvent();
}

final class InitialDataStarted extends SyncEvent {}

final class SyncStarted extends SyncEvent {
  final bool force;
  const SyncStarted({this.force = false});
}
