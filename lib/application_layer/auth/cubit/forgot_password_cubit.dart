import '../../../core/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

import '../../application_layer.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit(this._authBloc) : super(const ForgotPasswordState());
  final AuthBloc _authBloc;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      msg: "",
    ));
  }

  void sendTapped() {
    final status = Formz.validate([state.email]);
    if (status == FormzStatus.valid) {
      _authBloc.add(ForgotPasswordRequested(state.email.value));
    } else {
      emit(state.copyWith(
        status: Status.failure,
        msg: "put valid email",
      ));
    }
  }
}
