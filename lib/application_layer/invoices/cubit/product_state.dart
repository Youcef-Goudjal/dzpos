part of 'product_cubit.dart';

class ProductState extends Equatable {
  const ProductState({
    this.product = FullProduct.empty,
    this.status = Status.initial,
    this.msg,
    this.categoryName = "",
    this.save = false,
  });
  final bool save;
  final FullProduct product;
  final Status status;
  final String? msg;
  final String categoryName;

  @override
  List<Object?> get props => [product, status, categoryName];

  ProductState copyWith({
    FullProduct? product,
    Status? status,
    String? msg,
    String? categoryName,
    bool? save,
  }) =>
      ProductState(
        product: product ?? this.product,
        status: status ?? this.status,
        msg: msg ?? this.msg,
        categoryName: categoryName ?? this.categoryName,
        save: save ?? this.save,
      );
}
