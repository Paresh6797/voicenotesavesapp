part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}
final class LoginValid extends LoginState {}

final class LoginEmail extends LoginState {
  final String errorMessage;
  LoginEmail(this.errorMessage);
}
final class LoginPass extends LoginState {
  final String errorMessage;
  LoginPass(this.errorMessage);
}

final class LoginLoading extends LoginState {}
final class LoginSuccess extends LoginState {}
final class LoginFailure extends LoginState {
  final String error;
  LoginFailure({required this.error});
}
