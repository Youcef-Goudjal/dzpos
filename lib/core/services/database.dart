import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import '../../data/data.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../product/product.dart';
import '../core.dart';



part 'database.g.dart';
part 'tables.dart';

@DriftDatabase(
  // include:{"sql.drift"},
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
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    StorageKeys.dbPath.setValue(file.path);
    return NativeDatabase(file);
  });
}
