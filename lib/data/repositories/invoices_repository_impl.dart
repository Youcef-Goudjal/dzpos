import 'package:dzpos/core/common_blocs/common_blocs.dart';
import 'package:dzpos/core/services/database.dart';
import "package:dzpos/domain/repositories/invoices_repository.dart";

class InvoicesRepositoryImpl implements InvoicesRepository {
  final invoicesDao = CommonBloc.invoicesDao;

  @override
  Future<List<Product>> getAllMaterials() {
    // TODO: implement getAllMaterials
    throw UnimplementedError();
  }

  @override
  Future<Product> getProductById(int id) {
    // TODO: implement getProductById
    throw UnimplementedError();
  }

  @override
  Future<void> insertProduct(Product product) {
    // TODO: implement insertProduct
    throw UnimplementedError();
  }

  @override
  Future<void> updateProduct(Product product) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }

  @override
  Stream<List<ProductCategory>> getCategories() {
    return invoicesDao.watchAllCategories();
  }

  @override
  Future<void> deleteProduct(int id) {
    return invoicesDao.deleteProduct(id);
  }

  @override
  Future<void> insertCategory(String name) {
    return invoicesDao.insertCategory(name);
  }

  @override
  Stream<List<Product>> watchAllMaterials() {
    // TODO: implement watchAllMaterials
    throw UnimplementedError();
  }
}
