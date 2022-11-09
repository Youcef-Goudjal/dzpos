import '../../application_layer.dart';
import '../../../core/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 'verify_otp_state.dart';

class VerifyOtpCubit extends Cubit<VerifyOtpState> {
  final PhoneAuthBloc _authBloc;
  VerifyOtpCubit(this._authBloc) : super(const VerifyOtpState());

  onOTPCodeChanged(String value) {
    emit(state.copyWith(
      otpCode: OTPCode.dirty(value),
    ));
  }

  onVerifyTapped() {
    emit(state.copyWith(status: Status.loading));
    final formStatus = Formz.validate([state.otpCode]);
    if (formStatus.isInvalid) {
      emit(state.copyWith(status: Status.failure, msg: "invalid form"));
    } else {
      final authState = _authBloc.state;
      if (authState is PhoneAuthCodeSentSuccess) {
        _authBloc.add(VerifySentOtpEvent(
          otpCode: state.otpCode.value,
          verificationId: authState.verificationId,
        ));
      } else {
        emit(state.copyWith(
            status: Status.failure,
            msg: "Something went wrong try register again",));
      }
    }
  }
}
