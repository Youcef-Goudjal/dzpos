part of 'login_cubit.dart';

class LoginState extends Equatable {
  final Email email;
  final Password password;
  final Status status;
  final String msg;

  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = Status.initial,
    this.msg = "",
  });

  @override
  List<Object> get props => [email, password, status];

  LoginState copyWith({
    Email? email,
    Password? password,
    Status? status,
    String? msg,
  }) =>
      LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        msg: msg ?? this.msg,
        status: status ?? this.status,
      );
}
