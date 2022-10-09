import 'package:drift/drift.dart';
import 'package:dzpos/core/services/database.dart';
import 'package:dzpos/data/data.dart';

part 'invoices_daos.g.dart';

@DriftAccessor(tables: [
  Products,
  Users,
  Customers,
  Suppliers,
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
  Future<void> deleteProduct(int id) {
    return transaction(() async {
      await products.deleteWhere((tbl) => tbl.productId.equals(id));
    });
  }

  @override
  Future<List<ProductModel>> getAllMaterials() {
    final query = select(products).join([
      leftOuterJoin(productCategories,
          productCategories.categoryId.equalsExp(products.categoryId)),
      leftOuterJoin(
          productUnits, productUnits.unitId.equalsExp(products.unitId)),
    ]);

    return query.map((row) {
      return ProductModel(
        product: row.readTable(products),
        category: row.readTable(productCategories),
        unit: row.readTable(productUnits),
      );
    }).get();
  }

  @override
  Future<void> insertProduct(Product product) {
    return transaction(() async {
      await into(products).insert(product);
    });
  }

  @override
  Future<void> updateProduct(Product product) {
    return transaction(() async {
      await (products.update()
            ..where((tbl) => tbl.productId.equals(product.productId)))
          .write(product);
    });
  }

  @override
  Stream<List<ProductModel>> watchAllMaterials() {
    final query = select(products).join([
      leftOuterJoin(productCategories,
          productCategories.categoryId.equalsExp(products.categoryId)),
      leftOuterJoin(
          productUnits, productUnits.unitId.equalsExp(products.unitId)),
    ]);

    return query.map((row) {
      return ProductModel(
        product: row.readTable(products),
        category: row.readTable(productCategories),
        unit: row.readTable(productUnits),
      );
    }).watch();
  }

  Stream<List<ProductCategory>> watchAllCategories() {
    final query = select(productCategories);
    return query.watch();
  }

  Future<void> insertCategory(String name) {
    return transaction(() async {
      productCategories.insertOne(
        ProductCategoriesCompanion.insert(categoryName: name),
      );
    });
  }
}
