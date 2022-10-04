part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class Unauthenticated extends AuthState {
  const Unauthenticated();
}

class Authenticating extends AuthState {
  const Authenticating();
}

class Authenticated extends AuthState {
  const Authenticated({required this.user});
  final UserEntity user;

  @override
  List<Object> get props => [user];
}

class AuthError extends AuthState {
  const AuthError({
    required this.exception,
  });

  final Exception exception;

  @override
  List<Object> get props => [exception];
}
