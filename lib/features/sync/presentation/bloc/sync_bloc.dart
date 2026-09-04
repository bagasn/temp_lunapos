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

    // final mainDataJob = _repository.getInitialData();
    // final productJob = _repository.getInitialDataProduct();
    // final promoJob = _repository.getInitialDataPromo();

    // final (mainResult, productResult, promoResult) = await (
    //   mainDataJob,
    //   productJob,
    //   promoJob,
    // ).wait;

    // Failure? syncFailure;
    // mainResult.fold(
    //   (failure) {
    //     syncFailure = failure;
    //     _initialDataConfig[InitialDataType.dataMain] = false;
    //   },
    //   (isSuccess) {
    //     _initialDataConfig[InitialDataType.dataMain] = true;
    //   },
    // );
    // productResult.fold(
    //   (failure) {
    //     if (syncFailure != null) {
    //       syncFailure = failure;
    //     }
    //     _initialDataConfig[InitialDataType.dataProduct] = false;
    //   },
    //   (isSuccess) {
    //     _initialDataConfig[InitialDataType.dataProduct] = true;
    //   },
    // );
    // promoResult.fold(
    //   (failure) {
    //     if (syncFailure != null) {
    //       syncFailure = failure;
    //     }
    //     _initialDataConfig[InitialDataType.dataPromo] = false;
    //   },
    //   (isSuccess) {
    //     _initialDataConfig[InitialDataType.dataPromo] = true;
    //   },
    // );

    // if (syncFailure != null) {
    //   emit(SyncFailed(syncFailure!));
    // } else {
    //   emit(SyncCompleted());
    // }
  }
}
