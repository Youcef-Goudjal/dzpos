import 'package:flutter/src/material/date.dart';

import '../../core/common_blocs/common_blocs.dart';
import '../../core/services/database.dart';
import "../../domain/repositories/accounts_repository.dart";
import '../data.dart';

class AccountsRepositoryImpl implements AccountsRepository {
  final AccountsDao accountsDao = CommonBloc.accountsDao;

  @override
  Future<int> addAccount(AccountsCompanion newAccount) {
    return accountsDao.addAccount(newAccount);
  }

  @override
  Future<void> addMultipleAccounts(List<AccountsCompanion> accountsList) {
    return accountsDao.addMultipleAccounts(accountsList);
  }

  @override
  Future<List<Account>> get allAccounts => accountsDao.allAccounts;

  @override
  Future<int> updateAccount(AccountsCompanion updatedAccount) {
    return accountsDao.updateAccount(updatedAccount);
  }

  @override
  Stream<List<Account>> get watchAllAccounts => accountsDao.watchAllAccounts;

  @override
  Stream<List<DebtModel>> get debts => accountsDao.getDebts;

  @override
  Future<int> registerDebt(DebtsCompanion newDebt) {
    return accountsDao.registerDebt(newDebt);
  }

  @override
  Stream<List<Debt>> debtOfAccount(int accountId) {
    return accountsDao.debtOfAccount(accountId);
  }

  @override
  Future<void> deleteDebt(int id) {
    return accountsDao.deleteDebt(id);
  }

  @override
  Future<List<Debt>> getDebtBetweenDatesOfAccount(
      int accountId, DateTimeRange date) {
    return accountsDao.getDebtBetweenDatesOfAccount(accountId, date);
  }
}
