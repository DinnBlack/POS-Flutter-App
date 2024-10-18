part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoginInProgress extends AuthState {}

class AuthLoginSuccess extends AuthState {
  final User user;
  final bool isNewUser;

  AuthLoginSuccess(this.user, {required this.isNewUser});
}

class AuthLoginFailure extends AuthState {
  final String error;

  AuthLoginFailure(this.error);
}
