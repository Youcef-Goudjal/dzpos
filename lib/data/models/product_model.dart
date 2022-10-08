import '../../core/services/database.dart';

class ProductModel {
  final Product product;
  final ProductCategory category;
  final ProductUnit unit;

  ProductModel({required this.product, required this.category, required this.unit});
}
