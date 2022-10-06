part of 'reset_password_cubit.dart';

class ResetPasswordState extends Equatable {
  const ResetPasswordState({
    this.status = Status.initial,
    this.code = const Code.pure(),
    this.newPassword = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.msg,
  });

  final Status status;
  final Code code;
  final Password newPassword;
  final ConfirmedPassword confirmedPassword;

  final String? msg;

  @override
  List<Object> get props => [status, code, newPassword, confirmedPassword];

  ResetPasswordState copyWith({
    Status? status,
    Code? code,
    Password? newPassword,
    ConfirmedPassword? confirmedPassword,
    String? msg,
  }) =>
      ResetPasswordState(
        status: status ?? this.status,
        code: code ?? this.code,
        newPassword: newPassword ?? this.newPassword,
        confirmedPassword: confirmedPassword ?? this.confirmedPassword,
        msg: msg ?? this.msg,
      );
}
