import '../../../core/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

import '../../application_layer.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final AuthBloc _authBloc;
  ResetPasswordCubit(this._authBloc) : super(const ResetPasswordState());

  void codeChanged(String value) {
    emit(state.copyWith(code: Code.dirty(value)));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(newPassword: Password.dirty(value)));
  }

  void confirmPasswordChanged(String value) {
    emit(state.copyWith(
        confirmedPassword: ConfirmedPassword.dirty(
      password: state.newPassword.value,
      value: value,
    )));
  }

  void resetTapped() {
    final formStatus = Formz.validate([
      state.code,
      state.confirmedPassword,
      state.newPassword,
    ]);

    if (formStatus == FormzStatus.valid) {
      emit(state.copyWith(
        status: Status.success,
        msg: "resetting your password",
      ));
      _authBloc.add(ConfirmPasswordResetRequested(
        state.code.value,
        state.newPassword.value,
      ));
    } else {
      emit(state.copyWith(
        status: Status.failure,
        msg: "Fix fields",
      ));
    }
  }
}
