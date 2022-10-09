part of 'product_cubit.dart';

class ProductState extends Equatable {
  const ProductState({
    this.product = ProductEntity.empty,
    this.status = Status.initial,
  });

  final ProductEntity product;
  final Status status;

  @override
  List<Object> get props => [product, status];
}
