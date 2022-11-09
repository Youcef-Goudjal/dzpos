import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../data.dart';

abstract class AccountsDataSource {
  Future<int> addAccount(AccountsCompanion customer);
  Future<int> updateAccount(AccountsCompanion updatedCustomer);
  Future<void> addMultipleAccounts(List<AccountsCompanion> customers);
  Future<List<Account>> get allAccounts;
  Stream<List<Account>> get watchAllAccounts;
  Stream<List<DebtModel>> get getDebts;
  Stream<List<Debt>> debtOfAccount(int accountId);
  Future<void> deleteDebt(int id);
  Future<int> registerDebt(DebtsCompanion newDebt);
  Future<List<Debt>> getDebtBetweenDatesOfAccount(
      int accountId, DateTimeRange date);
}

// class AccountsDataSourceImpl implements AccountsDataSource {
//   // TODO: implement your AccountsDataSourceImpl
// }
