import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'account_statement_state.dart';

class AccountStatementCubit extends Cubit<AccountStatementState> {
  AccountStatementCubit() : super(const AccountStatementState());

  void saveDialogData(dynamic account, DateTimeRange date) {
    emit(state.copyWith(
      account: account,
      date: date,
    ));
  }
}
