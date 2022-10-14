import 'package:dzpos/core/common_blocs/common_blocs.dart';
import 'package:dzpos/core/services/database.dart';
import "package:dzpos/domain/repositories/invoices_repository.dart";

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
  Future<int> startInvoice(InvoicesCompanion invoice) {
    return invoicesDao.startInvoice(invoice);
  }
}
