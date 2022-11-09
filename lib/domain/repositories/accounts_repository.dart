import 'package:flutter/material.dart';

import '../../core/services/database.dart';
import '../../data/data.dart';

abstract class AccountsRepository {
  Future<int> addAccount(AccountsCompanion account);
  Future<int> updateAccount(AccountsCompanion updatedAccount);
  Future<void> addMultipleAccounts(List<AccountsCompanion> accounts);
  Future<List<Account>> get allAccounts;
  Stream<List<Account>> get watchAllAccounts;

  // debts
  Stream<List<DebtModel>> get debts;
  Stream<List<Debt>> debtOfAccount(int accountId);
  Future<int> registerDebt(DebtsCompanion newDebt);
  Future<void> deleteDebt(int id);
  Future<List<Debt>> getDebtBetweenDatesOfAccount(
      int accountId, DateTimeRange date);
}
