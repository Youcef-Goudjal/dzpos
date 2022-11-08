import 'package:dzpos/core/services/database.dart';
import 'package:flutter/material.dart';

abstract class AccountsDataSource {
  Future<int> addAccount(AccountsCompanion customer);
  Future<int> updateAccount(AccountsCompanion updatedCustomer);
  Future<void> addMultipleAccounts(List<AccountsCompanion> customers);
  Future<List<Account>> get allAccounts;
  Stream<List<Account>> get watchAllAccounts;
  Stream<List<FullDebt>> get getDebts;
  Stream<List<Debt>> debtOfAccount(int accountId);
  Future<void> deleteDebt(int id);
  Future<int> registerDebt(DebtsCompanion newDebt);
  Future<List<Debt>> getDebtBetweenDatesOfAccount(
      int accountId, DateTimeRange date);
}

// class AccountsDataSourceImpl implements AccountsDataSource {
//   // TODO: implement your AccountsDataSourceImpl
// }
