import 'package:drift/drift.dart';
import '../../../core/enums.dart';
import '../../../core/services/database.dart';
import '../../../data/data.dart';
import '../../../domain/domain.dart';
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
      try {
        repository.addAccount(
          AccountsCompanion.insert(
            name: state.name,
            accountType: state.accountType,
            address: Value(state.address),
            contact: Value(state.contact),
            code: Value(state.code),
          ),
        );
        emit(state.copyWith(
          status: Status.success,
          msg: "account added successfully",
        ));
      } on Exception {
        emit(state.copyWith(
          status: Status.failure,
          msg: "error occurs",
        ));
      }
    }
  }
}
