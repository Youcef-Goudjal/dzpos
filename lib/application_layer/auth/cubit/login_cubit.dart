import '../../application_layer.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

import '../../../core/enums.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthBloc _authBloc;
  LoginCubit(this._authBloc) : super(const LoginState());

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Status.initial,
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      status: Status.initial,
    ));
  }

  void loggingTaped() {
    emit(state.copyWith(
      status: Status.loading,
    ));
    final status = Formz.validate([state.email, state.password]);
    if (status == FormzStatus.valid) {
      _authBloc.add(SignInRequested(
        email: state.email.value,
        password: state.password.value,
      ));
    } else {
      emit(state.copyWith(
        status: Status.failure,
        msg: "You can't logged until you fill email and password correctly",
      ));
    }
  }
}
