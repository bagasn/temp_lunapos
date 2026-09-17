part of 'select_pos_user_bloc.dart';

sealed class SelectPosUserEvent extends Equatable {
  const SelectPosUserEvent();

  @override
  List<Object> get props => [];
}

final class FetchPosUsers extends SelectPosUserEvent {
  const FetchPosUsers();
}

final class SearchPosUsers extends SelectPosUserEvent {
  final String keyword;
  const SearchPosUsers(this.keyword);

  @override
  List<Object> get props => [keyword];
}
