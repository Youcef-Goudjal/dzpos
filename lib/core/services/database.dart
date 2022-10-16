import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:dzpos/data/data.dart';
import 'package:equatable/equatable.dart';
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
    // TODO:print(dbFolder);
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

class FullProduct extends Equatable {
  final Product product;
  final ProductCategory category;
  final List<ProductUnit> unitsList;

  ProductUnit? get getUnit {
    if (unitsList.isNotEmpty) {
      return unitsList.first;
    }
    return null;
  }

  int get productId => product.id;
  String get productName => product.name;
  String? get productCode => product.code;
  double get unitInStock => product.unitInStock;
  String get categoryName => category.name;

  const FullProduct({
    required this.product,
    required this.category,
    required this.unitsList,
  });

  bool get isEmpty => this == empty;
  bool get isNotEmpty => !isEmpty;
  static const empty = FullProduct(
    product: Product(
        id: -1,
        name: "",
        categoryId: -1,
        unitInStock: 0,
        discountPercentage: 1,
        reorderLevel: 1),
    category: ProductCategory(id: -1, name: ""),
    unitsList: [],
  );

  FullProduct copyWith({
    Product? product,
    ProductCategory? category,
    List<ProductUnit>? unitsList,
  }) =>
      FullProduct(
        product: product ?? this.product,
        category: category ?? this.category,
        unitsList: unitsList ?? this.unitsList,
      );
  @override
  List<Object?> get props => [product, category, unitsList];
  @override
  String toString() {
    return "$product-category:$category-units:${unitsList.length}";
  }
}

class DebtWithAccount {
  final Debt debt;
  final Account? account;

  DebtWithAccount({
    required this.debt,
    this.account,
  });
}

class FullInvoice {
  final Invoice invoice;
  final List<FullSale> sales;
  final Account account;

  FullInvoice(this.invoice, this.sales, this.account);
}

class FullSale {
  final Sale sale;
  final FullProduct product;

  FullSale(this.sale, this.product);
}
