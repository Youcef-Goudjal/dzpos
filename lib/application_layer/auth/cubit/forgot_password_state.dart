part of 'forgot_password_cubit.dart';

class ForgotPasswordState extends Equatable {
  final Email email;

  final Status status;
  final String msg;

  const ForgotPasswordState({
    this.email = const Email.pure(),
    this.status = Status.initial,
    this.msg = "",
  });

  @override
  List<Object> get props => [email, status, msg];

  ForgotPasswordState copyWith({
    Email? email,
    Status? status,
    String? msg,
  }) =>
      ForgotPasswordState(
        email: email ?? this.email,
        msg: msg ?? this.msg,
        status: status ?? this.status,
      );
}
