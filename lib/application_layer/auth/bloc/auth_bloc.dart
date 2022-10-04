import 'dart:async';
import 'dart:developer';

import 'package:dzpos/core/extensions/extensions.dart';
import 'package:dzpos/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  late final StreamSubscription<UserEntity> _userSubscription;
  AuthBloc(this._authRepository) : super(const Authenticating()) {
    on<AuthenticationStarted>(_onAuthenticationStarted);
    on<UserStateChanged>(_onUserStateChanged);
    on<SignInRequested>(_signIn);
    on<AuthFailed>(_authFailed);
    on<SignOutRequested>(_signOut);
    _userSubscription = _authRepository.user.listen((user) {
      if (i != 0) {
        add(UserStateChanged(user));
      } else {
        i++;
      }
    });
  }
  int i = 0;
  FutureOr<void> _onAuthenticationStarted(
      AuthenticationStarted event, Emitter<AuthState> emit) async {
    final user = _authRepository.currentUser;

    // for display splash screen
    await Future.delayed(5.seconds);
    if (user.isNotEmpty) {
      emit(Authenticated(user: user));
    } else {
      emit(const Unauthenticated());
    }
  }

  Future<void> _signIn(SignInRequested event, Emitter emit) async {
    emit(const Authenticating());

    try {
      final user = await _authRepository.logInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      if (user.isNotEmpty) {
        emit(Authenticated(user: user));
      } else {
        emit(const Unauthenticated());
      }
    } catch (e) {
      add(AuthFailed(exception: Exception(e)));
    }
  }

  Future<void> _authFailed(AuthFailed event, Emitter emit) async {
    log('Error: ${event.exception}');
    emit(AuthError(exception: event.exception));
    // await _authRepository.deleteCredentials();
    emit(const Unauthenticated());
  }

  Future<void> _signOut(SignOutRequested event, Emitter emit) async {
    try {
      await _authRepository.logOut();

      emit(const Unauthenticated());
    } catch (e) {
      add(AuthFailed(exception: Exception(e)));
    }
  }

  FutureOr<void> _onUserStateChanged(
      UserStateChanged event, Emitter<AuthState> emit) {
    if (event.user.isEmpty) {
      emit(const Unauthenticated());
    } else {
      emit(Authenticated(
        user: event.user,
      ));
    }
  }
}
