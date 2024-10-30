part of 'user_list_cubit.dart';

@immutable
sealed class UserListState {}

final class UserListInitial extends UserListState {}

final class UserListLoading extends UserListState {}

final class UserListLoaded extends UserListState {
  final List<User> users;
  UserListLoaded(this.users);
}

final class UserListError extends UserListState {
  final String error;
  UserListError(this.error);
}
