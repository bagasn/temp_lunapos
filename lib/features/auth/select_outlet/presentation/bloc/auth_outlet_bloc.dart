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
  final OutletLoginUseCase _outletLoginUseCase;

  String _searchKeyword = '';
  List<AuthOutletEntity> _allOutlets = [];

  AuthOutletBloc(
    this._sessionManager,
    this._databaseManager,
    this._getOutletUseCase,
    this._outletLoginUseCase,
  ) : super(const AuthOutletInitial()) {
    on<AuthOutletFetchStarted>(_onFetch);
    on<AuthOutletsLoaded>(_onOutletsLoaded);
    on<AuthOutletSearchChanged>(_onSearchChanged);
    on<AuthOutletSelected>(_onOutletSelected);

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
    AuthOutletSearchChanged event,
    Emitter<AuthOutletState> emit,
  ) {
    _searchKeyword = event.keyword.toLowerCase().trim();

    emit(AuthOutletFetching());

    add(AuthOutletsLoaded(_allOutlets));
  }

  Future<void> _onOutletSelected(
    AuthOutletSelected event,
    Emitter<AuthOutletState> emit,
  ) async {
    emit(const AuthOutletTokenFetching());
    final result = await _outletLoginUseCase(OutletLoginParams(event.outlet));
    await result.fold(
      (error) {
        emit(AuthOutletFailure(error));
      },
      (data) async {
        final isOpened = await _databaseManager.openMainDatabase(
          tenantId: event.outlet.companyId,
          outletId: event.outlet.outletId,
        );

        if (isOpened) {
        } else {}
      },
    );
  }

  void _startFetchInitialData() async {}
}
