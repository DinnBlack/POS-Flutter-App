part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthLoginWithGoogle extends AuthEvent {}

class AuthCheckStatus extends AuthEvent {}
