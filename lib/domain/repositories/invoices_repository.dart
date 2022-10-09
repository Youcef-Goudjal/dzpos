import 'package:dzpos/core/services/database.dart';

abstract class InvoicesRepository {
  /// get or watch all materials
  /// return list of products
  Future<List<Product>> getAllMaterials();
  Stream<List<Product>> watchAllMaterials();

  /// get product By id
  Future<Product> getProductById(int id);
  // crud product
  Future<void> insertProduct(Product product);
  Future<void> updateProduct(Product product);
  Future<void> deleteProduct(int id);

  /// product categories
  Stream<List<ProductCategory>> getCategories();
  Future<void> insertCategory(String name);
}
