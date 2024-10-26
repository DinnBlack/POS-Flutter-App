// lib/blocs/auth/auth_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:pos_flutter_app/features/auth/data/auth_firebase.dart';


part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthFirebase _authFirebase;

  AuthBloc(this._authFirebase) : super(AuthInitial()) {
    on<AuthLoginWithGoogle>(_onLoginWithGoogle);
    on<AuthCheckStatus>(_onCheckStatus);
  }

  Future<void> _onLoginWithGoogle(
      AuthLoginWithGoogle event, Emitter<AuthState> emit) async {
    emit(AuthLoginInProgress());
    try {
      final result = await _authFirebase.signInWithGoogle();

      if (result != null) {
        final user = result['user'] as User;
        final isNewUser = result['isNewUser'] as bool;

        emit(AuthLoginSuccess(user, isNewUser: isNewUser));
      } else {
        emit(AuthLoginFailure('Google sign-in failed'));
      }
    } catch (e) {
      emit(AuthLoginFailure(e.toString()));
    }
  }

  Future<void> _onCheckStatus(AuthCheckStatus event, Emitter<AuthState> emit) async {
    final isLoggedIn = await _authFirebase.isLoggedIn();
    if (isLoggedIn) {
      final user = await _authFirebase.getCurrentUser();
      emit(AuthLoginSuccess(user!, isNewUser: false));
    } else {
      emit(AuthInitial());
    }
  }
}

