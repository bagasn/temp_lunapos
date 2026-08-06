import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/core/local_storage/outlet_preferences.dart';
import 'package:pos/features/auth/login/domain/usecases/login_usecase.dart';
import 'package:pos/features/auth/select_outlet/domain/entities/outlet_entity.dart';
import 'package:pos/features/auth/select_outlet/presentation/bloc/select_outlet_event.dart';
import 'package:pos/features/auth/select_outlet/presentation/bloc/select_outlet_state.dart';
import 'package:pos/core/local_storage/auth_preferences.dart';
import 'package:pos/core/database/app_database_manager.dart';

@injectable
class SelectOutletBloc extends Bloc<SelectOutletEvent, SelectOutletState> {
  final SelectOutletUseCase _selectOutletUseCase;
  final OutletPreferences _outletPreferences;
  final AuthPreferences _authPreferences;
  final AppDatabaseManager _appDatabaseManager;
  List<OutletEntity> _allOutlets = [];

  SelectOutletBloc(
    this._selectOutletUseCase,
    this._outletPreferences,
    this._authPreferences,
    this._appDatabaseManager,
  ) : super(const SelectOutletInitial()) {
    on<OutletsLoaded>(_onOutletsLoaded);
    on<OutletSearchChanged>(_onSearchChanged);
    on<OutletSelected>(_onOutletSelected);
  }

  void _onOutletsLoaded(OutletsLoaded event, Emitter<SelectOutletState> emit) {
    _allOutlets = event.outlets;
    emit(
      SelectOutletLoaded(allOutlets: _allOutlets, filteredOutlets: _allOutlets),
    );
  }

  void _onSearchChanged(
    OutletSearchChanged event,
    Emitter<SelectOutletState> emit,
  ) {
    final keyword = event.keyword.toLowerCase().trim();
    final filtered = keyword.isEmpty
        ? _allOutlets
        : _allOutlets
              .where((o) => o.outletName.toLowerCase().contains(keyword))
              .toList();
    emit(
      SelectOutletLoaded(
        allOutlets: _allOutlets,
        filteredOutlets: filtered,
        keyword: event.keyword,
      ),
    );
  }

  Future<void> _onOutletSelected(
    OutletSelected event,
    Emitter<SelectOutletState> emit,
  ) async {
    emit(const SelectOutletSelecting());
    final result = await _selectOutletUseCase(
      SelectOutletParams(event.outlet.posAuthKey),
    );
    result.fold((failure) => emit(SelectOutletFailure(failure.message)), (
      _,
    ) async {
      final companyId = await _authPreferences.companyId();

      if (companyId != null) {
        final success = await _appDatabaseManager.openDatabase(
          tenantId: companyId,
          outletId: event.outlet.outletId.toString(),
        );

        if (!success) {
          emit(const SelectOutletFailure('Gagal membuka database lokal.'));
          return;
        }
      }

      await _outletPreferences.saveSelectedOutlet(
        outletId: event.outlet.outletId,
        outletName: event.outlet.outletName,
        companyName: event.outlet.companyName,
        posAuthKey: event.outlet.posAuthKey,
        outletPictureUrl: event.outlet.outletPictureUrl,
      );
      emit(const SelectOutletSuccess());
    });
  }
}
