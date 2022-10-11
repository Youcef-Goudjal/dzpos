import 'package:dzpos/core/services/database.dart';

abstract class AccountsDataSource {
  Future<int> addAccount(AccountsCompanion customer);
  Future updateAccount(AccountsCompanion updatedCustomer);
  Future<void> addMultipleAccounts(List<AccountsCompanion> customers);
  Future<List<Account>> get allCustomers;
  Stream<List<Account>> get watchAllCustomers;
}

// class AccountsDataSourceImpl implements AccountsDataSource {
//   // TODO: implement your AccountsDataSourceImpl
// }
