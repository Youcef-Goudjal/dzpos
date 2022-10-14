import 'package:drift/drift.dart';
import 'package:dzpos/core/services/database.dart';
import 'package:dzpos/data/data.dart';

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
  Future<int> startInvoice(InvoicesCompanion invoice) {
    return into(invoices).insert(invoice);
  }
}
