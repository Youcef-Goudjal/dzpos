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
  Future<void> insertProduct({
    required String name,
    required String barcode,
    required int categoryId,
    required double purchasePrice,
    required double salePrice,
    required double minInStock,
  }) {
    return invoicesDao.insertProduct(
      barcode: barcode,
      categoryId: categoryId,
      minInStock: minInStock,
      name: name,
      purchasePrice: purchasePrice,
      salePrice: salePrice,
    );
  }

  @override
  Future<void> updateProduct(Product product) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }

  @override
  Stream<List<ProductCategory>> watchAllCategories() {
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
