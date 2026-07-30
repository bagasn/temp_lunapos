import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/features/sync/domain/usecases/execute_sync_usecase.dart';
import 'package:pos/features/sync/presentation/bloc/sync_event.dart';
import 'package:pos/features/sync/presentation/bloc/sync_state.dart';

@injectable
class SyncBloc extends Bloc<SyncEvent, SyncState> {
  final ExecuteSyncUseCase _executeSyncUseCase;

  SyncBloc(this._executeSyncUseCase) : super(const SyncInitial()) {
    on<SyncStarted>(_onSyncStarted);
  }

  Future<void> _onSyncStarted(
    SyncStarted event,
    Emitter<SyncState> emit,
  ) async {
    emit(const SyncInProgress());
    final result = await _executeSyncUseCase(
      SyncParams(force: event.force),
    );
    result.fold(
      (failure) => emit(SyncFailed(failure.message)),
      (_) => emit(const SyncCompleted()),
    );
  }
}
