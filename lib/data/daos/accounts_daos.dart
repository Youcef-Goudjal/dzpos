import 'package:drift/drift.dart';
import 'package:dzpos/core/services/database.dart';
import 'package:dzpos/data/data.dart';

part "accounts_daos.g.dart";

@DriftAccessor(tables: [Customers, Suppliers])
class AccountsDao extends DatabaseAccessor<MyDatabase>
    with _$AccountsDaoMixin
    implements AccountsDataSource {
  AccountsDao(super.attachedDatabase);

  @override
  Future<int> addCustomer(CustomersCompanion customer) {
    return into(customers).insert(customer);
  }

  @override
  Future<List<Customer>> get allCustomers => select(customers).get();

  @override
  Future<void> addMultipleCustomers(
      List<CustomersCompanion> customersEntry) async {
    await batch((batch) {
      batch.insertAll(customers, customersEntry);
    });
  }

  @override
  // TODO: i
  @override
  Future<void> addMultipleSuppliers(
      List<SuppliersCompanion> suppliersEntry) async {
    await batch((batch) {
      batch.insertAll(suppliers, suppliersEntry);
    });
  }

  @override
  Future<int> addSupplier(SuppliersCompanion supplier) {
    return into(suppliers).insert(supplier);
  }

  @override
  Future<List<Supplier>> get allSuppliers => select(suppliers).get();
}
