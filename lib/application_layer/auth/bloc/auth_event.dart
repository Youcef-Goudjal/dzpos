part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
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
  const SignOutRequested();
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
