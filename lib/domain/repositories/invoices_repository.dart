import 'package:dzpos/domain/domain.dart';

abstract class InvoicesRepository {
  /// get or watch all materials
  /// return list of products
  Future<List<ProductEntity>> getAllMaterials();
  Stream<List<ProductEntity>> watchAllMaterials();

  /// get product By id
  Future<ProductEntity> getProductById(int id);

  Future<void> insertProduct(ProductEntity product);
  Future<void> updateProduct(ProductEntity product);
  Future<void> deleteProduct(int id);
}
