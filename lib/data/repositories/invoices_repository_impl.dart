import '../../application_layer/application_layer.dart';
import '../../core/common_blocs/common_blocs.dart';
import '../../core/services/database.dart';
import "../../domain/repositories/invoices_repository.dart";
import '../data.dart';

class InvoicesRepositoryImpl implements InvoicesRepository {
  final invoicesDao = CommonBloc.invoicesDao;

  @override
  Future<List<ProductCategory>> get categories => invoicesDao.categories;

  @override
  Future<int> insertCategory(ProductCategoriesCompanion category) {
    return invoicesDao.insertCategory(category);
  }

  @override
  Future<int> insertProduct(ProductsCompanion product) {
    return invoicesDao.insertProduct(product);
  }

  @override
  Future<List<Product>> get getProducts => invoicesDao.getProducts;

  @override
  Future<void> insertMultipleProducts(List<ProductsCompanion> products) {
    return invoicesDao.insertMultipleProducts(products);
  }

  @override
  Stream<List<ProductModel>> get watchProducts => invoicesDao.watchProducts;

  @override
  Future<InvoiceModel> createEmptyInvoice() {
    return invoicesDao.createEmptyInvoice();
  }

  @override
  Future<ProductModel> createEmptyProduct() {
    return invoicesDao.createEmptyProduct();
  }

  @override
  Future<void> writeProduct(ProductModel fullProduct) {
    return invoicesDao.writeProduct(fullProduct);
  }

  @override
  Future<InvoiceModel> get allInvoices => invoicesDao.allInvoices;

  @override
  Future<void> writeInvoice(InvoiceModel fullInvoice,
      {InvoiceState action = InvoiceState.New}) {
    return invoicesDao.writeInvoice(fullInvoice, action: action);
  }

  @override
  Stream<List<ProductCategory>> get watchCategories =>
      invoicesDao.watchCategories;

  @override
  Future<void> deleteProduct(int productId) {
    return invoicesDao.deleteProduct(productId);
  }

  @override
  Future<void> deleteInvoice(InvoiceModel invoiceId) {
    return invoicesDao.deleteInvoice(invoiceId);
  }

  @override
  Future<void> removeUnit(int unitId) {
    return invoicesDao.removeUnit(unitId);
  }

  @override
  Stream<List<InvoiceModel>> get watchAllInvoices =>
      invoicesDao.watchAllInvoices;

  @override
  Future<int> deleteMultipleInvoices(List<int> ids) {
    return invoicesDao.deleteMultipleInvoices(ids);
  }

  @override
  Future<void> removeSale(int saleId) {
    return invoicesDao.removeSale(saleId);
  }

  @override
  Future<List<ProductModel>> loadProducts({int? accountId}) {
    return invoicesDao.loadProducts(accountId: accountId);
  }
}
