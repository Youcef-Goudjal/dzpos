import 'package:dzpos/core/services/database.dart';

abstract class InvoicesRepository {
  Future<List<ProductCategory>> get categories;
  Stream<List<ProductCategory>> get watchCategories;
  Future<int> insertCategory(ProductCategoriesCompanion category);
  Future<int> insertProduct(ProductsCompanion product);
  Future<void> removeUnit(int unitId);

  Future<void> writeProduct(FullProduct fullProduct);
  Future<FullProduct> createEmptyProduct();
  Future<void> insertMultipleProducts(List<ProductsCompanion> products);
  Future<List<Product>> get getProducts;
  Stream<List<FullProduct>> get watchProducts;
  Future<FullInvoice> createEmptyInvoice();
  Future<FullInvoice> get allInvoices;
  Stream<List<FullInvoice>> get watchAllInvoices;
  Future<void> writeInvoice(FullInvoice fullInvoice);
  Future<void> deleteProduct(int productId);
  Future<void> deleteInvoice(int invoiceId);
  Future<void> removeSale(int saleId);
  Future<int> deleteMultipleInvoices(List<int> ids);
}
