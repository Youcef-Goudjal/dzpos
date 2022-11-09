import '../../application_layer/application_layer.dart';
import '../../core/services/database.dart';
import '../data.dart';

abstract class InvoicesDataSource {
  Future<List<ProductCategory>> get categories;
  Stream<List<ProductCategory>> get watchCategories;
  Future<int> insertCategory(ProductCategoriesCompanion category);
  Future<int> insertProduct(ProductsCompanion product);
  Future<void> writeProduct(ProductModel fullProduct);
  Future<ProductModel> createEmptyProduct();
  Future<void> removeUnit(int unitId);
  Future<void> insertMultipleProducts(List<ProductsCompanion> products);
  Future<List<Product>> get getProducts;
  Stream<List<ProductModel>> get watchProducts;
  Future<InvoiceModel> createEmptyInvoice();
  Future<InvoiceModel> get allInvoices;
  Stream<List<InvoiceModel>> get watchAllInvoices;
  Future<void> writeInvoice(InvoiceModel fullInvoice,
      {InvoiceState action = InvoiceState.New});
  Future<void> deleteProduct(int productId);
  Future<void> removeSale(int saleId);
  Future<List<ProductModel>> loadProducts({int? accountId});
  Future<void> deleteInvoice(InvoiceModel invoiceId);
  Future<int> deleteMultipleInvoices(List<int> ids);
}

// class InvoicesDataSourceImpl implements InvoicesDataSource {}
