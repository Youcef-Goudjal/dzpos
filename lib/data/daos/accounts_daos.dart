import 'package:drift/drift.dart';
import 'package:dzpos/core/services/database.dart';
import 'package:dzpos/data/data.dart';

part "accounts_daos.g.dart";

@DriftAccessor(tables: [Accounts])
class AccountsDao extends DatabaseAccessor<MyDatabase>
    with _$AccountsDaoMixin
    implements AccountsDataSource {
  AccountsDao(super.attachedDatabase);

  @override
  Future<int> addAccount(AccountsCompanion customer) {
    return into(accounts).insert(customer);
  }

  @override
  Future<void> addMultipleAccounts(List<AccountsCompanion> accountsList) {
    return batch((batch) {
      batch.insertAll(accounts, accountsList);
    });
  }

  @override
  Future<List<Account>> get allCustomers => select(accounts).get();

  @override
  Future updateAccount(AccountsCompanion updatedAccount) {
    return (update(accounts)
          ..where((tbl) => tbl.id.equals(updatedAccount.id.value)))
        .write(updatedAccount);
  }

  @override
  Stream<List<Account>> get watchAllCustomers => select(accounts).watch();
}
