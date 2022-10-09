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
    final query = select(products);

    return query.map((row) {
      return ProductModel(
        product: row,
        // category: row.readTableOrNull(productCategories),
        // unit: row.readTableOrNull(productUnits),
      );
    }).get();
  }

  @override
  Future<void> insertProduct({
    required String name,
    required String barcode,
    required int categoryId,
    required double purchasePrice,
    required double salePrice,
    required double minInStock,
  }) {
    return transaction(() async {
      final i = await into(products).insert(ProductsCompanion.insert(
        productCode: barcode,
        productName: name,
        unitId: 0,
        categoryId: categoryId,
        unitInStock: minInStock,
        unitPrice: salePrice,
        discountPercentage: 100,
        reorderLevel: 0,
        userId: 0,
      ));
      print("iiiiiiiiiiiiii $i");
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
  Stream<List<Product>> watchAllMaterials() {
    final query = select(products);
    // .join([
    //   leftOuterJoin(productCategories,
    //       productCategories.categoryId.equalsExp(products.categoryId)),
    //   leftOuterJoin(
    //       productUnits, productUnits.unitId.equalsExp(products.unitId)),
    // ])
    //   ..where(products.categoryId.equalsExp(productCategories.categoryId) &
    //       products.unitId.equalsExp(productUnits.unitId));

    return query.watch();
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
