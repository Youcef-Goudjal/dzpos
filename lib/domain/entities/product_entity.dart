import 'package:dzpos/domain/entities/entities.dart';
import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int? id;
  final String? code;
  final String? name;
  final ProductUnitEntity? unit;
  final ProductCategoryEntity? category;
  final double? unitPrice;
  final double? discountPercentage;
  final double? reorderLevel;
  final UserEntity? user;

  const ProductEntity({
    this.id,
    this.code,
    this.name,
    this.unit,
    this.category,
    this.unitPrice,
    this.discountPercentage,
    this.reorderLevel,
    this.user,
  });

  @override
  List<Object?> get props => [
        id,
        code,
        name,
        unit,
        category,
        unitPrice,
        discountPercentage,
        reorderLevel,
        user,
      ];
}

class ProductUnitEntity extends Equatable {
  final int? id;
  final String? name;

  const ProductUnitEntity({this.id, this.name});
  @override
  List<Object?> get props => [id, name];
}

class ProductCategoryEntity extends Equatable {
  final int? id;
  final String? name;

  const ProductCategoryEntity({this.id, this.name});
  @override
  List<Object?> get props => [id, name];
}
