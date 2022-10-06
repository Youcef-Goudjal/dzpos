part of 'login_phone_cubit.dart';

class LoginPhoneState extends Equatable {
  final Phone phone;
  final Status status;
  final String? msg;
  const LoginPhoneState({
    this.phone = const Phone.pure(),
    this.status = Status.initial,
    this.msg,
  });

  

  @override
  List<Object> get props => [phone, status];
  LoginPhoneState copyWith({
    Phone? phone,
    Status? status,
    String? msg,
  }) =>
      LoginPhoneState(
        phone: phone ?? this.phone,
        status: status ?? this.status,
        msg: msg ?? this.msg,
      );
}
