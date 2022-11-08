import 'package:dzpos/core/services/database.dart';

import '../../application_layer/application_layer.dart';
import '../../core/enums.dart';

abstract class InvoicesDataSource {
  Future<List<ProductCategory>> get categories;
  Stream<List<ProductCategory>> get watchCategories;
  Future<int> insertCategory(ProductCategoriesCompanion category);
  Future<int> insertProduct(ProductsCompanion product);
  Future<void> writeProduct(FullProduct fullProduct);
  Future<FullProduct> createEmptyProduct();
  Future<void> removeUnit(int unitId);
  Future<void> insertMultipleProducts(List<ProductsCompanion> products);
  Future<List<Product>> get getProducts;
  Stream<List<FullProduct>> get watchProducts;
  Future<FullInvoice> createEmptyInvoice();
  Future<FullInvoice> get allInvoices;
  Stream<List<FullInvoice>> get watchAllInvoices;
  Future<void> writeInvoice(FullInvoice fullInvoice,
      {InvoiceState action = InvoiceState.New});
  Future<void> deleteProduct(int productId);
  Future<void> removeSale(int saleId);
  Future<List<FullProduct>> loadProducts({int? accountId});
  Future<void> deleteInvoice(FullInvoice invoiceId);
  Future<int> deleteMultipleInvoices(List<int> ids);
}

// class InvoicesDataSourceImpl implements InvoicesDataSource {}
