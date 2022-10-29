import '../services/database.dart';

extension ProductCategoryExt on ProductCategory {
  static const ProductCategory empty = ProductCategory(id: -1, name: "");
  bool get isEmpty => this == empty;
  bool get isNotEmpty => this != empty;
}

extension ProductExt on Product {
  static const Product empty = Product(
    id: -1,
    name: "",
    categoryId: -1,
    unitInStock: 0,
    discountPercentage: 1,
    reorderLevel: 1,
    isFrozen: false,
  );
  bool get isEmpty => this == empty;
  bool get isNotEmpty => this != empty;
}
