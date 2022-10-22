import 'dart:async';
import 'dart:developer';

import 'package:dzpos/core/common_blocs/common_blocs.dart';
import 'package:dzpos/core/extensions/extensions.dart';
import 'package:dzpos/data/models/models.dart';
import 'package:dzpos/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application_layer.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final UserRepository userRepository;
  late final StreamSubscription<UserEntity> userSubscription;
  AuthBloc(
    this.authRepository,
    this.userRepository,
  ) : super(const Authenticating()) {
    on<AuthenticationStarted>(_onAuthenticationStarted);
    on<UserStateChanged>(_onUserStateChanged);
    on<SignInRequested>(_signIn);
    on<AuthFailed>(_authFailed);
    on<SignOutRequested>(_signOut);
    on<ForgotPasswordRequested>(_onForgotPassword);
    on<ConfirmPasswordResetRequested>(_confirmPasswordReset);
    on<SingUpRequested>(_onSingUp);
    on<AddDeviceImei>(_onAddDeviceImei);
    userSubscription = authRepository.user.listen((user) {
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
    final user = authRepository.currentUser;

    // for display splash screen
    await Future.delayed(3.seconds);
    if (user.isNotEmpty) {
      emit(Authenticated(user: user));
    } else {
      emit(const Unauthenticated());
    }
  }

  Future<void> _signIn(SignInRequested event, Emitter emit) async {
    emit(const Authenticating());

    try {
      final user = await authRepository.logInWithEmailAndPassword(
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
      // first we remove the imei code from firestore
      final currentUser = CommonBloc.profileBloc.user;
      List<String> devices = [];
      devices.addAll(currentUser.devices);
      devices.remove(event.imei);
      await userRepository.updateUserData(currentUser.copyWith(
        devices: devices,
      ));
      await authRepository.logOut();

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

  Future<void> _onForgotPassword(
      ForgotPasswordRequested event, Emitter<AuthState> emit) async {
    try {
      await authRepository.forgotPassword(event.email);
    } catch (e) {
      add(AuthFailed(exception: Exception(e)));
    }
  }

  Future<void> _confirmPasswordReset(
      ConfirmPasswordResetRequested event, Emitter<AuthState> emit) async {
    try {
      await authRepository.confirmePasswordReset(event.code, event.newPassword);
    } catch (e) {
      add(AuthFailed(exception: Exception(e)));
    }
  }

  Future<void> _onSingUp(SingUpRequested event, Emitter<AuthState> emit) async {
    try {
      final uid = await authRepository.signUp(
          email: event.email, password: event.password);
      await userRepository.addUserData(UserModel(
        uid: uid,
        email: event.email,
        phoneNumber: event.phone,
        userName: event.username,
      ));
      CommonBloc.phoneAuthBloc.add(SendOtpToPhoneEvent(
        phoneNumber: event.phone,
      ));
    } catch (e) {
      add(AuthFailed(exception: Exception(e)));
    }
  }

  FutureOr<void> _onAddDeviceImei(
      AddDeviceImei event, Emitter<AuthState> emit) async {
    // first we add the imei code from firestore
    final currentUser = CommonBloc.profileBloc.user;
    List<String> devices = [];
    devices.addAll(currentUser.devices);
    devices.add(event.imei);
    await userRepository.updateUserData(currentUser.copyWith(
      devices: devices,
    ));
  }
}
