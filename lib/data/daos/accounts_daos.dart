import 'package:drift/drift.dart';
import 'package:dzpos/core/services/database.dart';
import 'package:dzpos/data/data.dart';
import 'package:flutter/src/material/date.dart';

part "accounts_daos.g.dart";

@DriftAccessor(tables: [Accounts, Debts])
class AccountsDao extends DatabaseAccessor<MyDatabase>
    with _$AccountsDaoMixin
    implements AccountsDataSource {
  AccountsDao(super.attachedDatabase);

  @override
  Future<int> addAccount(AccountsCompanion newAccount) {
    return into(accounts).insert(newAccount);
  }

  @override
  Future<void> addMultipleAccounts(List<AccountsCompanion> accountsList) {
    return batch((batch) {
      batch.insertAll(accounts, accountsList);
    });
  }

  @override
  Future<List<Account>> get allAccounts => select(accounts).get();

  @override
  Future<int> updateAccount(AccountsCompanion updatedAccount) {
    return (update(accounts)
          ..where((tbl) => tbl.id.equals(updatedAccount.id.value)))
        .write(updatedAccount);
  }

  @override
  Stream<List<Account>> get watchAllAccounts => select(accounts).watch();

  @override
  Stream<List<DebtWithAccount>> get getDebts {
    final query = select(debts).join([
      leftOuterJoin(accounts, accounts.id.equalsExp(debts.id)),
    ]);

    return query
        .map(
          (row) => DebtWithAccount(
            debt: row.readTable(debts),
            account: row.readTableOrNull(accounts),
          ),
        )
        .watch();
  }

  @override
  Future<int> registerDebt(DebtsCompanion newDebt) {
    return into(debts).insert(newDebt);
  }

  @override
  Stream<List<Debt>> debtOfAccount(int accountId) {
    return (select(debts)..where((row) => row.accountId.equals(accountId)))
        .watch();
  }

  @override
  Future<void> deleteDebt(int id) {
    return (delete(debts)..where((t) => t.id.equals(id))).go();
  }

  @override
  Future<List<Debt>> getDebtBetweenDatesOfAccount(
      int accountId, DateTimeRange date) {
    return ((select(debts)
          ..where(
            (tbl) => tbl.accountId.equals(accountId),
          ))
          ..where(
            (tbl) => tbl.dateRecorded.isBetweenValues(date.start, date.end),
          ))
        .get();
  }
}
