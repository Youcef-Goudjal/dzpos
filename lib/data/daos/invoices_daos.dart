import 'package:drift/drift.dart';
import 'package:dzpos/core/services/database.dart';
import 'package:dzpos/data/data.dart';
import 'package:dzpos/domain/domain.dart';

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
  Future<void> deleteProduct(ProductModel product) {
    return transaction(() async {
      await products.deleteOne(product.product);
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
  Future<void> insertProduct(ProductModel product) {
    return transaction(() async {
      final categoryId = await (into(productCategories)
          .insert(product.category, mode: InsertMode.insertOrIgnore));
      final unitId = await (into(productUnits)
          .insert(product.unit, mode: InsertMode.insertOrIgnore));

      await into(products).insert(product.product.copyWith(
        categoryId: categoryId,
        unitId: unitId,
      ));
    });
  }

  @override
  Future<void> updateProduct(ProductModel product) {
    return transaction(() async {
      await (products.update()
            ..where((tbl) => tbl.productId.equals(product.product.productId)))
          .write(product.product);
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
}

extension CategoryExt on ProductCategory {
  ProductCategoryEntity get toEntity {
    return ProductCategoryEntity(
      id: categoryId,
      name: categoryName,
    );
  }
}

extension UnitExt on ProductUnit {
  ProductCategoryEntity get toEntity {
    return ProductCategoryEntity(
      id: unitId,
      name: unitName,
    );
  }
}
