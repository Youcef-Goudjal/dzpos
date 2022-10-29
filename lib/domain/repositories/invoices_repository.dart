import 'package:dzpos/core/services/database.dart';

import '../../core/enums.dart';

abstract class InvoicesRepository {
  Future<List<ProductCategory>> get categories;
  Stream<List<ProductCategory>> get watchCategories;
  Future<int> insertCategory(ProductCategoriesCompanion category);
  Future<int> insertProduct(ProductsCompanion product);
  Future<void> removeUnit(int unitId);
  Future<List<FullProduct>> loadProducts({int? accountId});
  Future<void> writeProduct(FullProduct fullProduct);
  Future<FullProduct> createEmptyProduct();
  Future<void> insertMultipleProducts(List<ProductsCompanion> products);
  Future<List<Product>> get getProducts;
  Stream<List<FullProduct>> get watchProducts;
  Future<FullInvoice> createEmptyInvoice();
  Future<FullInvoice> get allInvoices;
  Stream<List<FullInvoice>> get watchAllInvoices;
  Future<void> writeInvoice(FullInvoice fullInvoice,
      {Actions? action = Actions.insert});
  Future<void> deleteProduct(int productId);
  Future<void> deleteInvoice(FullInvoice invoiceId);
  Future<void> removeSale(int saleId);
  Future<int> deleteMultipleInvoices(List<int> ids);
}
