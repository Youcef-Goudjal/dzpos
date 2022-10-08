import '../data.dart';

abstract class InvoicesDataSource {
  /// get or watch all materials
  /// return list of products
  Future<List<ProductModel>> getAllMaterials();
  Stream<List<ProductModel>> watchAllMaterials();

  Future<void> insertProduct(ProductModel product);
  Future<void> updateProduct(ProductModel product);
  Future<void> deleteProduct(ProductModel id);

  
}

class InvoicesDataSourceImpl implements InvoicesDataSource {
  @override
  Future<void> deleteProduct(ProductModel id) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  Future<List<ProductModel>> getAllMaterials() {
    // TODO: implement getAllMaterials
    throw UnimplementedError();
  }

  @override
  Future<void> insertProduct(ProductModel product) {
    // TODO: implement insertProduct
    throw UnimplementedError();
  }

  @override
  Future<void> updateProduct(ProductModel product) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }

  @override
  Stream<List<ProductModel>> watchAllMaterials() {
    // TODO: implement watchAllMaterials
    throw UnimplementedError();
  }
}
