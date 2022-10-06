import 'package:dzpos/application_layer/application_layer.dart';
import 'package:dzpos/core/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthBloc _authBloc;
  RegisterCubit(this._authBloc) : super(const RegisterState());

  onUsernameChanged(String value) {
    emit(state.copyWith(username: Username.dirty(value)));
  }

  onPasswordChanged(String value) {
    emit(state.copyWith(password: Password.dirty(value)));
  }

  onPhoneChanged(String value) {
    emit(state.copyWith(phone: Phone.dirty(value)));
  }

  onEmailChanged(String value) {
    emit(state.copyWith(email: Email.dirty(value)));
  }

  onConfirmedPasswordChanged(String value) {
    emit(state.copyWith(
        confirmedPassword: ConfirmedPassword.dirty(
      password: state.password.value,
      value: value,
    )));
  }

  onRegisterTapped() {
    final formStatus = Formz.validate([
      state.username,
      state.email,
      state.phone,
      state.password,
      state.confirmedPassword,
    ]);
    if (formStatus.isInvalid) {
      emit(state.copyWith(
        status: Status.failure,
        msg: "some input not valide !!",
      ));
    } else {
      _authBloc.add(SingUpRequested(
        state.username.value,
        state.email.value,
        state.password.value,
        state.phone.value,
      ));
      emit(state.copyWith(
        status: Status.success,
        msg: "Registering ...",
      ));
    }
  }
}
