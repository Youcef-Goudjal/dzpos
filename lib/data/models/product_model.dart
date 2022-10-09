import '../../core/services/database.dart';

class ProductModel {
  final Product product;
  final ProductCategory? category;
  final ProductUnit? unit;

  const ProductModel({
    required this.product,
    this.category,
    this.unit,
  });
}
