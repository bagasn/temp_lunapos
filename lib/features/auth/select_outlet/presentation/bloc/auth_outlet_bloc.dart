import 'package:drift/drift.dart';
import 'package:drift/extensions/native.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/core/database/setting_database.dart';
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
    _databaseManager.masterDb;
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
      (data) async {
        final settingDb = _databaseManager.settingDb;
        final createDate = DateTime.now();
        final newInserts = <TableOutletCompanion>[];

        for (int i = 0; i < data.length; i++) {
          final outlet = data[i];
          newInserts.add(
            TableOutletCompanion.insert(
              outletId: Value(outlet.outletId),
              tenantId: outlet.companyId,
              companyName: outlet.companyName,
              outletName: outlet.outletName,
              posAuthKey: outlet.posAuthKey,
              outletPictureUrl: Value(outlet.outletPictureUrl),
              subscriptionDueDate: Value(outlet.subscriptionDueDate),
              createdAt: Value(createDate),
            ),
          );
        }
        await settingDb.tableOutlet.insertAll(
          newInserts,
          mode: InsertMode.insertOrReplace,
        );

        add(AuthOutletsLoaded());
      },
    );
  }

  void _onOutletsLoaded(AuthOutletsLoaded event, Emitter emit) async {
    emit(AuthOutletFetching());

    try {
      final stQuery = _databaseManager.settingDb.tableOutlet.select()
        ..where((rowItem) {
          final keyword = _searchKeyword.toLowerCase();
          return Expression.or([
            rowItem.outletName.containsCase(keyword),
            rowItem.companyName.containsCase(keyword),
          ]);
        });

      final result = await stQuery.get();

      final outlets = result
          .map(
            (element) => AuthOutletEntity(
              outletId: element.outletId,
              outletName: element.outletName,
              companyId: element.tenantId,
              companyName: element.companyName,
              posAuthKey: element.posAuthKey,
              outletPictureUrl: element.outletPictureUrl,
              subscriptionDueDate: element.subscriptionDueDate,
            ),
          )
          .toList();

      emit(AuthOutletDataState(outlets: outlets));
    } catch (e) {
      emit(AuthOutletFailure(DatabaseFailure(e.toString())));
    }
  }

  void _onSearchChanged(
    AuthOutletSearchChanged event,
    Emitter<AuthOutletState> emit,
  ) {
    _searchKeyword = event.keyword.toLowerCase().trim();
    add(AuthOutletsLoaded());
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
        await _sessionManager.auth.saveOutletToken(
          accessToken: data.accessToken,
          refreshToken: data.refreshToken,
          haveLunaone: data.haveLunaone,
          lunaoneToken: data.tokenLunaone,
          lunaoneRefreshToken: data.refreshTokenLunaone,
        );

        try {
          await _databaseManager.openMainDatabase(
            tenantId: event.outlet.companyId,
            outletId: event.outlet.outletId,
          );

          _startFetchInitialData(outlet: event.outlet);
        } on DatabaseFailure catch (error) {
          emit(AuthOutletFailure(error));
        } catch (error) {
          emit(AuthOutletFailure(NetworkFailure.error(error)));
        }
      },
    );
  }

  void _startFetchInitialData({required AuthOutletEntity outlet}) async {}
}
