part of 'product_cubit.dart';

class ProductState extends Equatable {
  const ProductState({
    this.id,
    this.productName = "",
    this.productCode = "",
    this.categoryName = "",
    this.status = Status.initial,
    this.unitInStock = 0,
    this.purchasePrice = 0,
    this.salePrice = 0,
    this.category,
    this.units = const [],
  });
  final int? id;
  final String categoryName, productName, productCode;
  final Status status;
  final ProductCategory? category;
  final List<ProductUnit> units;
  final double unitInStock;
  final double purchasePrice, salePrice;

  @override
  List<Object?> get props => [
        id,
        status,
        categoryName,
        category,
        productCode,
        productName,
        unitInStock,
        purchasePrice,
        salePrice,
      ];

  ProductState copyWith({
    int? id,
    String? categoryName,
    String? productName,
    String? productCode,
    Status? status,
    double? unitInStock,
    double? price,
    double? box,
    ProductCategory? category,
    List<ProductUnit>? units,
  }) {
    return ProductState(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      productCode: productCode ?? this.productCode,
      categoryName: categoryName ?? this.categoryName,
      status: status ?? this.status,
      category: category ?? this.category,
      unitInStock: unitInStock ?? this.unitInStock,
      purchasePrice: price ?? purchasePrice,
      salePrice: box ?? salePrice,
      units: units ?? this.units,
    );
  }
}
