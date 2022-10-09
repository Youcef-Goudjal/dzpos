import '../../core/services/database.dart';
import '../data.dart';

abstract class InvoicesDataSource {
  /// get or watch all materials
  /// return list of products
  Future<List<ProductModel>> getAllMaterials();
  Stream<List<ProductModel>> watchAllMaterials();

  Future<void> insertProduct(Product product);
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
  Stream<List<ProductModel>> watchAllMaterials() {
    // TODO: implement watchAllMaterials
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
}
