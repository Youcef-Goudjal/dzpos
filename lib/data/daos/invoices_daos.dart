import 'package:drift/drift.dart';
import 'package:dzpos/core/enums.dart';
import 'package:dzpos/core/services/database.dart';
import 'package:dzpos/data/data.dart';
import 'package:rxdart/rxdart.dart';

part 'invoices_daos.g.dart';

@DriftAccessor(tables: [
  Products,
  Users,
  Accounts,
  ProductUnits,
  ProductCategories,
  Invoices,
  Sales,
])
class InvoicesDao extends DatabaseAccessor<MyDatabase>
    with _$InvoicesDaoMixin
    implements InvoicesDataSource {
  InvoicesDao(super.attachedDatabase);

  @override
  Future<List<ProductCategory>> get categories =>
      select(productCategories).get();

  @override
  Future<int> insertCategory(ProductCategoriesCompanion category) {
    return into(productCategories).insert(category);
  }

  @override
  Future<int> insertProduct(ProductsCompanion product) {
    return into(products).insert(product);
  }

  @override
  Future<List<Product>> get getProducts => select(products).get();

  @override
  Future<void> insertMultipleProducts(
      List<ProductsCompanion> productsList) async {
    batch((batch) async {
      batch.insertAll(products, productsList);
    });
  }

  @override
  Future<FullInvoice> createEmptyInvoice() async {
    final id = await into(invoices).insert(InvoicesCompanion.insert(
      customerId: -1,
      paymentType: PaymentType.cache,
      amountTendered: 0,
    ));
    final invoice = Invoice(
      id: id,
      customerId: -1,
      paymentType: PaymentType.cache,
      amountTendered: 0,
      dateRecorded: DateTime.now(),
    );
    const account = Account(
      id: -1,
      name: "",
      accountType: AccountType.none,
    );

    return FullInvoice(
      invoice,
      const [],
      account,
    );
  }

  @override
  Stream<List<FullProduct>> get watchProducts {
    final productStream = select(products).watch();
    return productStream.switchMap((value) {
      /// mapping id to product
      final idToProduct = {for (var p in value) p.id: p};
      final ids = idToProduct.keys;
      print("ids :$ids");
      // select all units and categories that are included in any product
      final entryQuery = select(products).join(
        [
          innerJoin(productCategories,
              productCategories.id.equalsExp(products.categoryId)),
          innerJoin(
              productUnits, productUnits.productId.equalsExp(products.id)),
        ],
      );
      // )..where(products.id.isIn(ids));

      return entryQuery.watch().map(
        (rows) {
          final idToUnits = <int, List<ProductUnit>>{};
          final idToCategories = <int, ProductCategory>{};

          for (final row in rows) {
            print("row:$row");
            final unit = row.readTable(productUnits);
            final category = row.readTable(productCategories);
            final id = row.readTable(products).id;
            idToUnits.putIfAbsent(id, () => []).add(unit);
            idToCategories.putIfAbsent(id, () => category);
          }

          return [
            for (var id in ids)
              FullProduct(
                product: idToProduct[id]!,
                category: idToCategories[id] ??
                    const ProductCategory(id: -1, name: ""),
                unitsList: idToUnits[id] ?? [],
              )
          ];
        },
      );
    });
  }

  @override
  Future<void> writeProduct(FullProduct entry) {
    return transaction(() async {
      final product = entry.product.copyWith(
        categoryId: entry.category.id,
      );

      // first we write the product
      await into(products).insert(product, mode: InsertMode.replace);

      // now we add the units
      for (final unit in entry.unitsList) {
        await into(productUnits).insert(
          ProductUnitsCompanion.insert(
            id: (unit.id == -1) ? const Value.absent() : Value(unit.id),
            code: unit.code,
            price: unit.price,
            productId: product.id,
            box: Value(unit.box),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  }

  @override
  Future<FullProduct> createEmptyProduct() async {
    final id = await into(products).insert(ProductsCompanion.insert(
      name: "",
      categoryId: -1,
      discountPercentage: 1,
      reorderLevel: 0,
    ));
    const product = FullProduct.empty;

    return product.copyWith(
      product: product.product.copyWith(id: id),
    );
  }

  @override
  Future<FullInvoice> get allInvoices => throw UnimplementedError();

  @override
  Future<void> writeInvoice(FullInvoice entry) {
    return transaction(() async {
      final invoice = entry.invoice.copyWith(
        customerId: entry.account.id,
      );
      // first we replace the invoice
      await into(invoices).insert(invoice, mode: InsertMode.replace);

      // now we add the sales
      for (var s in entry.sales) {
        await into(sales).insert(
          SalesCompanion.insert(
            salesId: (s.saleId == -1) ? const Value.absent() : Value(s.saleId),
            invoiceId: invoice.id,
            productId: s.productId,
            unitId: s.unitId,
            quantity: s.quantity,
            unitPrice: s.unitPrice,
            
          ),
        );
      }
    });
  }

  @override
  Stream<List<ProductCategory>> get watchCategories =>
      select(productCategories).watch();

  @override
  Future<void> deleteProduct(int productId) {
    return transaction(() async {
      // first we delete all units
      await (delete(productUnits)
            ..where((row) => row.productId.equals(productId)))
          .go();

      await (delete(products)..where((row) => row.id.equals(productId))).go();
    });
  }

  @override
  Future<void> deleteInvoice(int invoiceId) {
    return transaction(() async {
      await (delete(sales)..where((tbl) => tbl.invoiceId.equals(invoiceId)))
          .go();
      await (delete(invoices)..where((tbl) => tbl.id.equals(invoiceId))).go();
    });
  }

  @override
  Future<void> removeUnit(int unitId) {
    return transaction(() async {
      await (delete(productUnits)..where((tbl) => tbl.id.equals(unitId))).go();
    });
  }
}
