import '../../application_layer.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

import '../../../core/enums.dart';

part 'login_phone_state.dart';

class LoginPhoneCubit extends Cubit<LoginPhoneState> {
  final PhoneAuthBloc _authBloc;
  LoginPhoneCubit(this._authBloc) : super(const LoginPhoneState());

  onPhoneChanged(String value) {
    emit(state.copyWith(
      phone: Phone.dirty(value),
      status: Status.initial,
    ));
  }

  void onSendTapped() async {
    emit(state.copyWith(status: Status.loading));
    final formStatus = Formz.validate([state.phone]);
    if (formStatus.isInvalid) {
      return emit(state.copyWith(
        status: Status.failure,
        msg: "phone invalide",
      ));
    } else {
      _authBloc.add(SendOtpToPhoneEvent(phoneNumber: state.phone.value));
      emit(state.copyWith(
        status: Status.success,
        msg: "code sent !!",
      ));
    }
  }
}
