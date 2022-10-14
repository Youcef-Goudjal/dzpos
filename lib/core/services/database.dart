import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:dzpos/data/data.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../enums.dart';

part 'database.g.dart';
part 'tables.dart';

@DriftDatabase(
  tables: [
    Users,
    Products,
    ProductUnits,
    ProductCategories,
    Sales,
    Invoices,
    Accounts,
    ReceiveProducts,
    PurchaseOrders,
    Debts,
  ],
  daos: [InvoicesDao, AccountsDao],
)
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    print(dbFolder);
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

class FullProduct {
  final Product product;
  final ProductCategory category;
  final List<ProductUnit> units;

  FullProduct({
    required this.product,
    required this.category,
    required this.units,
  });
}

class DebtWithAccount {
  final Debt debt;
  final Account? account;

  DebtWithAccount({
    required this.debt,
    this.account,
  });
}
