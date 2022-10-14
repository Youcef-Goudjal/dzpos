import 'package:dzpos/core/services/database.dart';

abstract class InvoicesDataSource {
  Future<List<ProductCategory>> get categories;
  Future<int> insertCategory(ProductCategoriesCompanion category);
  Future<int> insertProduct(ProductsCompanion product);
  Future<void> insertMultipleProducts(List<ProductsCompanion> products);
  Future<List<Product>> get getProducts;
  Future<int> startInvoice(InvoicesCompanion invoice);
}

// class InvoicesDataSourceImpl implements InvoicesDataSource {}
