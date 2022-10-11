import 'package:drift/drift.dart';
import 'package:dzpos/core/enums.dart';
import 'package:dzpos/core/services/database.dart';
import 'package:dzpos/data/data.dart';
import 'package:dzpos/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'new_account_state.dart';

class NewAccountCubit extends Cubit<NewAccountState> {
  final AccountsRepository repository = AccountsRepositoryImpl();
  final Account? account;

  NewAccountCubit({
    this.account,
  }) : super(const NewAccountState()) {
    emit(state.copyWith(
      name: account?.name,
      code: account?.code,
      address: account?.address,
      contact: account?.contact,
      email: account?.email,
      accountType: account?.accountType,
    ));
  }

  onChangeIsAccountType(AccountType type) {
    emit(state.copyWith(
      accountType: type,
    ));
  }

  onChangeCode(String code) {
    emit(state.copyWith(
      code: code,
    ));
  }

  onChangeName(String name) {
    emit(state.copyWith(
      name: name,
    ));
  }

  onChangeEmail(String email) {
    emit(state.copyWith(
      email: email,
    ));
  }

  onChangeContact(String contact) {
    emit(state.copyWith(
      contact: contact,
    ));
  }

  onChangeAddress(String address) {
    emit(state.copyWith(
      address: address,
    ));
  }

  void save() {
    // if(name is not empty)
    if (state.name.isEmpty) {
      emit(state.copyWith(
        status: Status.failure,
      ));
    } else {
      repository.addAccount(
        AccountsCompanion(
          name: Value(state.name),
          address: Value(state.address),
          contact: Value(state.contact),
          code: Value(state.code),
          accountType: Value(state.accountType),
        ),
      );
    }
  }
}
