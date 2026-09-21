part of 'select_pos_user_bloc.dart';

sealed class SelectPosUserState extends Equatable {
  const SelectPosUserState();

  @override
  List<Object> get props => [];
}

final class SelectPosUserInitial extends SelectPosUserState {}

final class SelectPosUserLoading extends SelectPosUserState {}

final class SelectPosUserLoaded extends SelectPosUserState {
  /// Full unfiltered list from the database.
  final List<Users> allUsers;

  /// Filtered list based on the current search keyword.
  final List<Users> filteredUsers;

  const SelectPosUserLoaded({
    required this.allUsers,
    required this.filteredUsers,
  });

  @override
  List<Object> get props => [allUsers, filteredUsers];
}

final class SelectPosUserError extends SelectPosUserState {
  final String message;

  const SelectPosUserError(this.message);

  @override
  List<Object> get props => [message];
}
