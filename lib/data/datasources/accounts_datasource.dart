import 'package:dzpos/core/services/database.dart';

abstract class AccountsDataSource {
  Future<int> addCustomer(CustomersCompanion customer);
  Future<void> addMultipleCustomers(List<CustomersCompanion> customers);
  Future<List<Customer>> get allCustomers;

  Future<int> addSupplier(SuppliersCompanion supplier);
  Future<void> addMultipleSuppliers(List<SuppliersCompanion> suppliers);
  Future<List<Supplier>> get allSuppliers;
}

// class AccountsDataSourceImpl implements AccountsDataSource {
//   // TODO: implement your AccountsDataSourceImpl
// }
