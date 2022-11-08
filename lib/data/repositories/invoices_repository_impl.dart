import 'package:dzpos/core/common_blocs/common_blocs.dart';
import 'package:dzpos/core/services/database.dart';
import "package:dzpos/domain/repositories/invoices_repository.dart";

import '../../application_layer/application_layer.dart';
import '../../core/enums.dart';

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
  Stream<List<FullProduct>> get watchProducts => invoicesDao.watchProducts;

  @override
  Future<FullInvoice> createEmptyInvoice() {
    return invoicesDao.createEmptyInvoice();
  }

  @override
  Future<FullProduct> createEmptyProduct() {
    return invoicesDao.createEmptyProduct();
  }

  @override
  Future<void> writeProduct(FullProduct fullProduct) {
    return invoicesDao.writeProduct(fullProduct);
  }

  @override
  Future<FullInvoice> get allInvoices => invoicesDao.allInvoices;

  @override
  Future<void> writeInvoice(FullInvoice fullInvoice,
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
  Future<void> deleteInvoice(FullInvoice invoiceId) {
    return invoicesDao.deleteInvoice(invoiceId);
  }

  @override
  Future<void> removeUnit(int unitId) {
    return invoicesDao.removeUnit(unitId);
  }

  @override
  Stream<List<FullInvoice>> get watchAllInvoices =>
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
  Future<List<FullProduct>> loadProducts({int? accountId}) {
    return invoicesDao.loadProducts(accountId: accountId);
  }
}
