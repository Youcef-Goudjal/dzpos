part of 'product_cubit.dart';

enum ProductStatus {
  newProduct,
  updateProduct;

  bool get isUpdating => this == ProductStatus.updateProduct;
  bool get isNew => this == ProductStatus.newProduct;
}

class ProductState extends Equatable {
  const ProductState({
    this.product = FullProduct.empty,
    this.status = Status.initial,
    this.productStatus = ProductStatus.newProduct,
    this.msg,
    this.categoryName = "",
    this.save = false,
  });
  final bool save;
  final FullProduct product;
  final Status status;
  final ProductStatus productStatus;
  final String? msg;
  final String categoryName;

  @override
  List<Object?> get props =>
      [product, status, categoryName, productStatus, save];

  ProductState copyWith({
    FullProduct? product,
    Status? status,
    ProductStatus? state,
    String? msg,
    String? categoryName,
    bool? save,
  }) {
    return ProductState(
      product: product ?? this.product,
      status: status ?? this.status,
      msg: msg ?? this.msg,
      categoryName: categoryName ?? this.categoryName,
      save: save ?? this.save,
      productStatus: state ?? productStatus,
    );
  }
}
