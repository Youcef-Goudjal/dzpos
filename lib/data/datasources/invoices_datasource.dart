import '../../core/services/database.dart';
import '../data.dart';

abstract class InvoicesDataSource {
  /// get or watch all materials
  /// return list of products
  Future<List<ProductModel>> getAllMaterials();
  Stream<List<Product>> watchAllMaterials();

  Future<void> insertProduct({
    required String name,
    required String barcode,
    required int categoryId,
    required double purchasePrice,
    required double salePrice,
    required double minInStock,
  });
  Future<void> updateProduct(Product product);
  Future<void> deleteProduct(int id);
}

class InvoicesDataSourceImpl implements InvoicesDataSource {
  @override
  Future<void> deleteProduct(int id) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  Future<List<ProductModel>> getAllMaterials() {
    // TODO: implement getAllMaterials
    throw UnimplementedError();
  }

  @override
  Stream<List<Product>> watchAllMaterials() {
    // TODO: implement watchAllMaterials
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
    // TODO: implement insertProduct
    throw UnimplementedError();
  }

  @override
  Future<void> updateProduct(Product product) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }
}
