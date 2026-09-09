import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/features/sync/domain/repositories/sync_repository.dart';
import 'package:pos/features/sync/presentation/bloc/sync_event.dart';
import 'package:pos/features/sync/presentation/bloc/sync_state.dart';
import 'package:pos/shared/domain/entities/failure.dart';

enum InitialDataType {
  dataMain, // Initial Data
  dataProduct, // Initial Product
  dataPromo, // Initial Promo
}

@injectable
class SyncBloc extends Bloc<SyncEvent, SyncState> {
  final SyncRepository _repository;

  final _initialDataConfig = <InitialDataType, bool>{};

  SyncBloc(this._repository) : super(const SyncInitial()) {
    on<InitialDataStarted>(_onInitialData);
  }

  Future<void> _onInitialData(InitialDataStarted event, Emitter emit) async {
    emit(SyncInProgress());
  }
}
