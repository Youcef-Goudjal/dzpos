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
    final id = await into(invoices).insert(const InvoicesCompanion());
    final invoice = Invoice(
      id: id,
      customerId: 0,
      paymentType: PaymentType.cache,
      amountTendered: 0,
      dateRecorded: DateTime.now(),
    );
    const account = Account(
      id: 0,
      name: "",
      accountType: AccountType.none,
    );

    return FullInvoice(
      invoice,
      [],
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
        await into(productUnits).insert(ProductUnitsCompanion.insert(
            code: unit.code,
            price: unit.price,
            productId: product.id,
            box: Value(unit.box)));
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
  Future<void> writeInvoice(FullInvoice fullInvoice) {
    throw UnimplementedError();
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
}
