import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/core/local_storage/session_manager.dart';
import 'package:pos/features/auth/select_outlet/domain/entities/auth_outlet_entity.dart';
import 'package:pos/features/auth/select_outlet/domain/usecases/auth_outlet_usecase.dart';
import 'package:pos/features/auth/select_outlet/presentation/bloc/auth_outlet_event.dart';
import 'package:pos/features/auth/select_outlet/presentation/bloc/auth_outlet_state.dart';
import 'package:pos/core/database/app_database_manager.dart';
import 'package:pos/shared/domain/entities/failure.dart';

@injectable
class AuthOutletBloc extends Bloc<AuthOutletEvent, AuthOutletState> {
  final SessionManager _sessionManager;
  final AppDatabaseManager _databaseManager;
  final GetAuthOutletUsecase _getOutletUseCase;

  String _searchKeyword = '';
  List<AuthOutletEntity> _allOutlets = [];

  AuthOutletBloc(
    this._sessionManager,
    this._databaseManager,
    this._getOutletUseCase,
  ) : super(const AuthOutletInitial()) {
    on<AuthOutletFetchStarted>(_onFetch);
    on<AuthOutletsLoaded>(_onOutletsLoaded);
    on<OutletSearchChanged>(_onSearchChanged);
    // on<OutletSelected>(_onOutletSelected);

    add(AuthOutletFetchStarted());
  }

  void _onFetch(AuthOutletFetchStarted event, Emitter emit) async {
    emit(AuthOutletFetching());

    final userToken = await _sessionManager.auth.userAccessToken();
    if (userToken == null) {
      return emit(AuthOutletFailure(AuthFailure('Cannot find authorization')));
    }

    final result = await _getOutletUseCase(GetAuthOutletParams(userToken));

    await result.fold(
      (failure) {
        emit(AuthOutletFailure(failure));
      },
      (data) {
        add(AuthOutletsLoaded(data));
      },
    );
  }

  void _onOutletsLoaded(
    AuthOutletsLoaded event,
    Emitter<AuthOutletState> emit,
  ) {
    _allOutlets = event.outlets;

    List<AuthOutletEntity> filteredOutlets;
    if (_searchKeyword.isEmpty) {
      filteredOutlets = _allOutlets;
    } else {
      filteredOutlets = _allOutlets.where((outlet) {
        final keyword = _searchKeyword.toLowerCase();
        if (outlet.outletName.toLowerCase().contains(keyword)) {
          return true;
        }
        if (outlet.companyName.toLowerCase().contains(keyword)) {
          return true;
        }
        return false;
      }).toList();
    }

    emit(AuthOutletDataState(outlets: filteredOutlets));
  }

  void _onSearchChanged(
    OutletSearchChanged event,
    Emitter<AuthOutletState> emit,
  ) {
    _searchKeyword = event.keyword.toLowerCase().trim();

    emit(AuthOutletFetching());

    add(AuthOutletsLoaded(_allOutlets));
  }

  Future<void> _onOutletSelected(
    OutletSelected event,
    Emitter<AuthOutletState> emit,
  ) async {
    // emit(const SelectOutletSelecting());
    // final result = await _selectOutletUseCase(
    //   // SelectOutletParams(event.outlet.posAuthKey),
    // );
    // result.fold((failure) => emit(SelectOutletFailure(failure.message)), (
    //   _,
    // ) async {
    // final companyId = await _authPreferences.companyId();

    // if (companyId != null) {
    //   final success = await _appDatabaseManager.openDatabase(
    //     tenantId: companyId,
    //     outletId: event.outlet.outletId.toString(),
    //   );

    //   if (!success) {
    //     emit(const SelectOutletFailure('Gagal membuka database lokal.'));
    //     return;
    //   }
    // }

    // await _outletPreferences.setOutletActive(
    //   outletId: event.outlet.outletId,
    //   outletName: event.outlet.outletName,
    //   companyName: event.outlet.companyName,
    //   posAuthKey: event.outlet.posAuthKey,
    //   outletPictureUrl: event.outlet.outletPictureUrl,
    // );
    // emit(const SelectOutletSuccess());
    // });
  }
}
