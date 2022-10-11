import 'package:dzpos/core/common_blocs/common_blocs.dart';
import 'package:dzpos/core/services/database.dart';
import 'package:dzpos/data/data.dart';
import "package:dzpos/domain/repositories/accounts_repository.dart";

class AccountsRepositoryImpl implements AccountsRepository {
  final AccountsDao accountsDao = CommonBloc.accountsDao;

  @override
  Future<int> addAccount(AccountsCompanion customer) {
    // TODO: implement addAccount
    throw UnimplementedError();
  }

  @override
  Future<void> addMultipleAccounts(List<AccountsCompanion> customers) {
    // TODO: implement addMultipleAccounts
    throw UnimplementedError();
  }

  @override
  // TODO: implement allCustomers
  Future<List<Account>> get allAccounts => throw UnimplementedError();

  @override
  Future<int> updateAccount(AccountsCompanion updatedCustomer) {
    // TODO: implement updateAccount
    throw UnimplementedError();
  }

  @override
  // TODO: implement watchAllCustomers
  Stream<List<Account>> get watchAllAccounts => throw UnimplementedError();
}
