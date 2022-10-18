import 'dart:async';

import 'package:drift/drift.dart';
import 'package:dzpos/core/enums.dart';
import 'package:dzpos/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/database.dart';

part 'debt_state.dart';

class DebtCubit extends Cubit<DebtState> {
  final AccountsRepository accountsRepository;
  late StreamSubscription? _subscription;

  DebtCubit(this.accountsRepository, bool type) : super(DebtState(type: type));

  void accountSelected(Account account) {
    _subscription = accountsRepository.debtOfAccount(account.id).listen(
      (event) {
        emit(state.copyWith(
          debts: event,
          accountId: account.id,
          account: account,
        ));
      },
    );
  }

  void onDescChanged(String desc) {
    emit(state.copyWith(
      desc: desc,
      status: Status.initial,
    ));
  }

  void onAmountChanged(String amount) {
    emit(state.copyWith(
      amount: amount,
      status: Status.initial,
    ));
  }

  void onTypeChanged(bool? input) {
    emit(state.copyWith(
      type: input,
      status: Status.initial,
    ));
  }

  void onSave() async {
    final amount = double.tryParse(state.amount);
    if (amount != null) {
      final id = await accountsRepository.registerDebt(DebtsCompanion.insert(
        isCredit: state.type,
        amount: amount,
        accountId: Value(state.accountId),
        description: Value(state.desc),
      ));
      emit(state.copyWith(
        status: Status.success,
        msg: "debt registered id:$id",
      ));
    } else {
      emit(state.copyWith(
        status: Status.failure,
        msg: "amount is not set",
      ));
    }
  }

  void onLongPressedTile(int id) async {
    await accountsRepository.deleteDebt(id);
    emit(state.copyWith(
      status: Status.success,
      msg: "element deleted successfully",
    ));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
