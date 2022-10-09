part of 'product_cubit.dart';

class ProductState extends Equatable {
  const ProductState({
    this.productName = "",
    this.productCode = "",
    this.categoryName = "",
    this.status = Status.initial,
    this.minimum = 0,
    this.purchasePrice = 0,
    this.salePrice = 0,
    this.category,
  });
  final String categoryName, productName, productCode;
  final Status status;
  final ProductCategory? category;
  final double minimum;
  final double purchasePrice, salePrice;

  @override
  List<Object?> get props => [
        status,
        categoryName,
        category,
        productCode,
        productName,
        minimum,
        purchasePrice,
        salePrice,
      ];

  ProductState copyWith({
    String? categoryName,
    String? productName,
    String? productCode,
    Status? status,
    double? minimum,
    double? purchasePrice,
    double? salePrice,
    ProductCategory? category,
  }) {
    return ProductState(
      productName: productName ?? this.productName,
      productCode: productCode ?? this.productCode,
      categoryName: categoryName ?? this.categoryName,
      status: status ?? this.status,
      category: category ?? this.category,
      minimum: minimum ?? this.minimum,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      salePrice: salePrice ?? this.salePrice,
    );
  }
}
