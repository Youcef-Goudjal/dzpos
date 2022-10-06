part of 'verify_otp_cubit.dart';

class VerifyOtpState extends Equatable {
  const VerifyOtpState({
    this.status = Status.initial,
    this.msg,
    this.otpCode = const OTPCode.pure(),
  });

  final Status status;
  final String? msg;
  final OTPCode otpCode;

  @override
  List<Object> get props => [status, otpCode];

  VerifyOtpState copyWith({
    Status? status,
    String? msg,
    OTPCode? otpCode,
  }) =>
      VerifyOtpState(
        status: status ?? this.status,
        msg: msg ?? this.msg,
        otpCode: otpCode ?? this.otpCode,
      );
}
