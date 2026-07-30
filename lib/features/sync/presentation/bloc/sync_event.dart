import 'package:equatable/equatable.dart';

sealed class SyncEvent extends Equatable {
  const SyncEvent();
  @override
  List<Object?> get props => [];
}

final class SyncStarted extends SyncEvent {
  final bool force;
  const SyncStarted({this.force = false});
  @override
  List<Object?> get props => [force];
}
