import 'package:dzpos/core/common_blocs/common_blocs.dart';
import 'package:dzpos/core/services/database.dart';
import 'package:dzpos/data/data.dart';
import "package:dzpos/domain/repositories/accounts_repository.dart";

class AccountsRepositoryImpl implements AccountsRepository {
  final AccountsDao accountsDao = CommonBloc.accountsDao;
  @override
  Future<int> addCustomer(CustomersCompanion customer) {
    return accountsDao.addCustomer(customer);
  }

  @override
  Future<void> addMultipleCustomers(List<CustomersCompanion> customers) {
    return accountsDao.addMultipleCustomers(customers);
  }

  @override
  // TODO: implement allCustomers
  Future<List<Customer>> get allCustomers => accountsDao.allCustomers;

  @override
  Future<void> addMultipleSuppliers(List<SuppliersCompanion> suppliers) {
    return accountsDao.addMultipleSuppliers(suppliers);
  }

  @override
  Future<int> addSupplier(SuppliersCompanion supplier) {
    return accountsDao.addSupplier(supplier);
  }

  @override
  // TODO: implement allSuppliers
  Future<List<Supplier>> get allSuppliers => accountsDao.allSuppliers;
}
