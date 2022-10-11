import '../../core/services/database.dart';

abstract class AccountsRepository {
  Future<int> addAccount(AccountsCompanion account);
  Future<int> updateAccount(AccountsCompanion updatedAccount);
  Future<void> addMultipleAccounts(List<AccountsCompanion> accounts);
  Future<List<Account>> get allAccounts;
  Stream<List<Account>> get watchAllAccounts;
}
