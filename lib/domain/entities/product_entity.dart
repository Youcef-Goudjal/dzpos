import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int id;
  final String name, barCode;
  final double minInStock, priceUnit;
  final int categoryId;
  final String categoryName;

  const ProductEntity({
    this.id = 0,
    this.name = "",
    this.barCode = "",
    this.minInStock = 0,
    this.priceUnit = 0,
    this.categoryId = 0,
    this.categoryName = "",
  });

  @override
  List<Object?> get props => [
        id,
        name,
        barCode,
        minInStock,
        priceUnit,
        categoryId,
        categoryName,
      ];
}
