part of 'register_cubit.dart';

class RegisterState extends Equatable {
  const RegisterState({
    this.status = Status.initial,
    this.msg,
    this.username = const Username.pure(),
    this.email = const Email.pure(),
    this.phone = const Phone.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
  });

  final Status status;
  final String? msg;

  final Username username;
  final Email email;
  final Phone phone;
  final Password password;
  final ConfirmedPassword confirmedPassword;

  @override
  List<Object> get props => [
        status,
        username,
        password,
        confirmedPassword,
        email,
        phone,
      ];

  RegisterState copyWith({
    Status? status,
    String? msg,
    Username? username,
    Email? email,
    Phone? phone,
    Password? password,
    ConfirmedPassword? confirmedPassword,
  }) =>
      RegisterState(
        status: status ?? this.status,
        msg: msg ?? this.msg,
        username: username ?? this.username,
        password: password ?? this.password,
        confirmedPassword: confirmedPassword ?? this.confirmedPassword,
        email: email ?? this.email,
        phone: phone ?? this.phone,
      );
}
