import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/core/database/app_database_manager.dart';
import 'package:pos/core/database/main_database.dart';

part 'select_pos_user_event.dart';
part 'select_pos_user_state.dart';

@injectable
class SelectPosUserBloc extends Bloc<SelectPosUserEvent, SelectPosUserState> {
  final AppDatabaseManager _databaseManager;

  String _searchKeyword = '';

  SelectPosUserBloc(this._databaseManager) : super(SelectPosUserInitial()) {
    on<FetchPosUsers>(_onFetch);
    on<SearchPosUsers>(_onSearch);
  }

  Future<void> _onFetch(FetchPosUsers event, Emitter<SelectPosUserState> emit) async {
    emit(SelectPosUserLoading());

    try {
      final db = await _databaseManager.mainDb;
      if (db == null) {
        return emit(const SelectPosUserError('Database tidak tersedia.'));
      }

      final allUsers = await db.managers.tableUser
          .filter((f) => f.deleted(false))
          .get();

      emit(SelectPosUserLoaded(allUsers: allUsers, filteredUsers: allUsers));
    } catch (e) {
      emit(SelectPosUserError(e.toString()));
    }
  }

  void _onSearch(SearchPosUsers event, Emitter<SelectPosUserState> emit) {
    _searchKeyword = event.keyword.toLowerCase().trim();

    final currentState = state;
    if (currentState is SelectPosUserLoaded) {
      final filtered = _searchKeyword.isEmpty
          ? currentState.allUsers
          : currentState.allUsers.where((u) {
              final name = (u.fullName ?? u.firstName ?? '').toLowerCase();
              return name.contains(_searchKeyword);
            }).toList();

      emit(
        SelectPosUserLoaded(
          allUsers: currentState.allUsers,
          filteredUsers: filtered,
        ),
      );
    }
  }
}
