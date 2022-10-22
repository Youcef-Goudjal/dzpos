part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthenticationStarted extends AuthEvent {}

class CheckingSession extends AuthEvent {
  const CheckingSession();
}

class SignInRequested extends AuthEvent {
  final String email, password;
  const SignInRequested({
    required this.email,
    required this.password,
  });
  @override
  List<Object> get props => [email, password];
}

class SignOutRequested extends AuthEvent {
  final String? imei;
  const SignOutRequested(this.imei);
  @override
  List<Object?> get props => [imei];
}

class AuthFailed extends AuthEvent {
  const AuthFailed({
    required this.exception,
  });

  final Exception exception;

  @override
  List<Object> get props => [exception];
}

class UserStateChanged extends AuthEvent {
  final UserEntity user;

  const UserStateChanged(this.user);
}

class ForgotPasswordRequested extends AuthEvent {
  final String email;

  const ForgotPasswordRequested(this.email);

  @override
  List<Object> get props => [email];
}

class ConfirmPasswordResetRequested extends AuthEvent {
  final String code;
  final String newPassword;
  const ConfirmPasswordResetRequested(this.code, this.newPassword);
  @override
  List<Object> get props => [code, newPassword];
}

class SingUpRequested extends AuthEvent {
  final String username, email, password, phone;

  const SingUpRequested(this.username, this.email, this.password, this.phone);

  @override
  List<Object> get props => [username, email, password, phone];
}

class AddDeviceImei extends AuthEvent {
  final String imei;

  const AddDeviceImei(this.imei);
  @override
  List<Object> get props => [imei];
}
