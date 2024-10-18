// lib/blocs/auth/auth_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:pos_flutter_app/services/firebase/auth_firebase.dart';


part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthFirebase _authFirebase;

  AuthBloc(this._authFirebase) : super(AuthInitial()) {
    on<AuthLoginWithGoogle>(_onLoginWithGoogle);
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
}

