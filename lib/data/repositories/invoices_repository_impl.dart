import 'package:dzpos/domain/entities/product_entity.dart';
import "package:dzpos/domain/repositories/invoices_repository.dart";

class InvoicesRepositoryImpl implements InvoicesRepository {
  @override
  Future<void> deleteProduct(int id) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  Future<List<ProductEntity>> getAllMaterials() {
    // TODO: implement getAllMaterials
    throw UnimplementedError();
  }

  @override
  Future<ProductEntity> getProductById(int id) {
    // TODO: implement getProductById
    throw UnimplementedError();
  }

  @override
  Future<void> insertProduct(ProductEntity product) {
    // TODO: implement insertProduct
    throw UnimplementedError();
  }

  @override
  Future<void> updateProduct(ProductEntity product) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }

  @override
  Stream<List<ProductEntity>> watchAllMaterials() {
    // TODO: implement watchAllMaterials
    throw UnimplementedError();
  }
  
}
