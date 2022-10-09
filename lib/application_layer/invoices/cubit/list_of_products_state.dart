part of 'list_of_products_cubit.dart';

class ListOfProductsState extends Equatable {
  const ListOfProductsState({
    this.status = Status.initial,
    this.products = const [],
  });
  final Status status;
  final List<Product> products;
  @override
  List<Object> get props => [status, products];

  ListOfProductsState copyWith({
    Status? status,
    List<Product>? products,
  }) =>
      ListOfProductsState(
        status: status ?? this.status,
        products: products ?? this.products,
      );
}
