part of 'product_cubit.dart';

enum ProductStatus {
  New,
  Update;

  bool get isUpdating => this == ProductStatus.Update;
  bool get isNew => this == ProductStatus.New;
}

class ProductState extends Equatable {
  const ProductState({
    this.product = FullProduct.empty,
    this.status = Status.initial,
    this.productStatus = ProductStatus.New,
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
    print("product status $state");
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
