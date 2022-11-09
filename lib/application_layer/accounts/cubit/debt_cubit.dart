import 'dart:async';

import 'package:drift/drift.dart';
import '../../../core/enums.dart';
import '../../../core/extensions/extensions.dart';
import '../../../domain/domain.dart';
import '../../../product/constants/constants.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/manager/language/locale_keys.g.dart';
import '../../../core/services/database.dart';

part 'debt_state.dart';

class DebtCubit extends Cubit<DebtState> {
  final AccountsRepository accountsRepository;
  StreamSubscription? _subscription;
  final scrollController = ScrollController();
  int offset = 0;
  final page = 10;
  DebtCubit(this.accountsRepository, bool type) : super(DebtState(type: type)) {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        emit(state.copyWith(
          viewPort: getViewPortItems(state.debts),
        ));
      }
    });
  }

  List<Debt> getViewPortItems(List<Debt> origine) {
    if (origine.isEmpty) return [];
    final startIndex = offset * page;
    if (startIndex >= origine.length) return state.viewPort;
    final endIndex = ((offset + 1) * page) > origine.length
        ? origine.length
        : (offset + 1) * page;
    List<Debt> list = [];
    list.addAll(state.viewPort);
    list.addAll(origine.sublist(startIndex, endIndex));
    return list;
  }

  void accountSelected(Account account) {
    _subscription = accountsRepository.debtOfAccount(account.id).listen(
      (debts) {
        emit(
          state.copyWith(
            debts: debts,
            accountId: account.id,
            account: account,
            viewPort: [],
          ),
        );
        emit(state.copyWith(
          viewPort: getViewPortItems(debts),
        ));
      },
    );
  }

  void onDescChanged(String desc) {
    emit(state.copyWith(
      desc: desc,
    ));
  }

  void onAmountChanged(String amount) {
    emit(state.copyWith(
      amount: amount,
    ));
  }

  void onTypeChanged(bool? input) {
    emit(state.copyWith(
      type: input,
    ));
  }

  void onSave(BuildContext context) async {
    final amount = double.tryParse(state.amount);
    if (StorageKeys.settingsShowDebtDialog.storedValue ?? true) {
      if (!(StorageKeys.settingsRememberDebtOption.storedValue ?? false)) {
        final result = await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("حدث الفواتير"),
              content: Text(
                  "عند التأكيد سيتم تقسيم المبلغ على الفواتير من الأقدم الى الأحدث"),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.error,
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    LocaleKeys.No,
                    style: TextStyle(
                      color: context.onError,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.primaryColor,
                  ),
                  onPressed: () => Navigator.pop(context, "Yes"),
                  child: Text(
                    LocaleKeys.Yes,
                    style: TextStyle(
                      color: context.onPrimaryColor,
                    ),
                  ),
                )
              ],
            );
          },
        );

        if (result == "Yes") {
          //TODO
        }
      }
    }
    if (amount != null) {
      final id = await accountsRepository.registerDebt(DebtsCompanion.insert(
        isCredit: state.type,
        deptType: state.debtType,
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
