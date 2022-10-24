import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:dzpos/data/data.dart';
import 'package:equatable/equatable.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../product/product.dart';
import '../enums.dart';
import '../utils/utils.dart';

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

  ProductUnit? unitById(int unitId) {
    try {
      return unitsList.where((element) => element.id == unitId).first;
    } on Exception {
      return null;
    }
  }

  double? get purchasePrice {
    try {
      return unitsList
          .where((element) => element.type == UnitType.buy)
          .first
          .price;
    } on Exception {
      return null;
    }
  }

  int get productId => product.id;
  String get productName => product.name;
  String? get productCode => product.code;
  double get unitInStock => product.unitInStock;
  String get categoryName => category.name;

  int? get unitId => getUnit?.id;
  double? get priceUnit => getUnit?.price;
  double? get boxUnit => getUnit?.box;
  String? get codeUnit => getUnit?.code;

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
      reorderLevel: 1,
      isFrozen: false,
    ),
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

class FullInvoice extends Equatable {
  final Invoice invoice;
  final List<FullSale> sales;
  final Account account;

  const FullInvoice(this.invoice, this.sales, this.account);

  int get invoiceId => invoice.id;
  int get accountId => account.id;
  PaymentType get paymentType => invoice.paymentType;
  double? get totalAmount => invoice.totalAmount;
  double get amountTendered => invoice.amountTendered;
  DateTime get dateRecorded => invoice.dateRecorded;
  String get name => account.name;

  int get salesLength => sales.length;

  double get total {
    double t = 0;
    for (var element in sales) {
      t += element.subTotal * element.quantity;
    }
    return t;
  }

  String get time {
    return "${dateRecorded.hour}-${dateRecorded.minute}";
  }

  String get date {
    return "${dateRecorded.day}-${dateRecorded.month}";
  }

  String get date2 {
    return "${dateRecorded.day}-${dateRecorded.month}-${dateRecorded.year}";
  }

  static final empty = FullInvoice(
    Invoice(
      id: -1,
      accountId: -1,
      paymentType: PaymentType.cache,
      invoiceType: InvoiceType.sell,
      amountTendered: 0,
      dateRecorded: DateTime(2022),
    ),
    const [],
    const Account(
      id: -1,
      name: "",
      accountType: AccountType.none,
      isFrozen: false,
    ),
  );
  bool get isEmpty => this == FullInvoice.empty;
  bool get isNotEmpty => !isEmpty;

  bool get isAccountEmpty => account == FullInvoice.empty.account;
  bool get isInvoiceEmpty => invoice == FullInvoice.empty.invoice;

  @override
  List<Object?> get props => [invoice, sales, account];
  FullInvoice copyWith({
    Invoice? invoice,
    List<FullSale>? sales,
    Account? account,
  }) =>
      FullInvoice(
        invoice ?? this.invoice,
        sales ?? this.sales,
        account ?? this.account,
      );
}

class FullSale extends Equatable {
  final Sale sale;
  final FullProduct product;

  int get saleId => sale.salesId;
  int get productId => sale.productId;
  int get invoiceId => sale.invoiceId;
  double get quantity => sale.quantity;
  int get unitId => sale.unitId;
  double get unitPrice => sale.unitPrice;
  // double get subTotal => sale.subTotal;
  String get productName => product.productName;

  const FullSale(this.sale, this.product);

  double get subTotal {
    double t = 0;
    final useBox = StorageKeys.settingsUseBox.storedValue ?? false;
    double box = useBox ? (product.unitById(unitId)?.box) ?? 1 : 1;
    t = quantity * unitPrice * box;
    return t;
  }

  @override
  List<Object?> get props => [sale, product];

  FullSale copyWith({
    Sale? sale,
    FullProduct? product,
  }) =>
      FullSale(
        sale ?? this.sale,
        product ?? this.product,
      );

  String getIndex(int col) {
    switch (col) {
      case 0:
        return "$productId";
      case 1:
        return productName;
      case 2:
        return formatCurrency(unitPrice);
      case 3:
        return quantity.toString();
      case 4:
        formatCurrency(subTotal);
    }
    return "";
  }
}
