import '../../core/services/database.dart';

abstract class AccountsRepository {
  Future<int> addCustomer(CustomersCompanion customer);
  Future<void> addMultipleCustomers(List<CustomersCompanion> customers);
  Future<List<Customer>> get allCustomers;

  Future<int> addSupplier(SuppliersCompanion supplier);
  Future<void> addMultipleSuppliers(List<SuppliersCompanion> suppliers);
  Future<List<Supplier>> get allSuppliers;
}
