import 'package:equatable/equatable.dart';

import '../../core/core.dart';
import '../../product/constants/constants.dart';

class ProductModel extends Equatable {
  final Product product;
  final ProductCategory category;
  final List<ProductUnit> unitsList;

  const ProductModel({
    required this.product,
    required this.category,
    required this.unitsList,
  });

  // getters
  int get productId => product.id;
  String get productName => product.name;
  double get unitInStock => product.unitInStock;
  String get categoryName => category.name;

  /// [unit] return [ProductUnit]
  /// three options
  /// [PricingPolicy.fixed] : getting the element by [product.fixedUnitId]
  /// if fixed unit id not defined will return [product.unit1] as default option
  /// [PricingPolicy.last] : get the id of the last operation in sales table
  /// [PricingPolicy.lastAccount] : get the id of the last account operation
  /// in sales table
  /// if any error occurred will return [emptyProductUnit]
  ProductUnit get unit {
    final pricingPolicy =
        PricingPolicy.values[StorageKeys.pricingMethod.storedValue ?? 0];
    switch (pricingPolicy) {
      case PricingPolicy.fixed:
        return getUnitById(product.fixedUnitId);
      case PricingPolicy.last:
        return emptyProductUnit;

      case PricingPolicy.lastAccount:
        return emptyProductUnit;
    }
  }

  /// get Unit by id
  /// look for the element in units list if not founded
  /// will return [emptyProductUnit]
  /// [id] the unit id => -1 will return unit1 as default option
  ProductUnit getUnitById(int id) {
    return unitsList.firstWhere(
      (element) {
        if (id != -1) return element.id == id;
        // if the fixed unit is null return unit 1 by default
        return element.id == product.unit1;
      },
      orElse: () => emptyProductUnit,
    );
  }

  double get salePriceUnit => unit.salePrice;
  double get purchasePriceUnit => unit.purchasePrice;
  double get boxUnit => unit.box;

  bool get isEmpty => this == empty;
  bool get isNotEmpty => !isEmpty;
  static const empty = ProductModel(
    product: emptyProduct,
    category: emptyCategory,
    unitsList: [],
  );

  ProductModel copyWith({
    Product? product,
    ProductCategory? category,
    List<ProductUnit>? unitsList,
  }) =>
      ProductModel(
        product: product ?? this.product,
        category: category ?? this.category,
        unitsList: unitsList ?? this.unitsList,
      );

  @override
  List<Object?> get props => [product, category, unitsList];
  @override
  String toString() {
    return "$product-category:$category-units:${unitsList.length}";
  }
}

const emptyProduct = Product(
  id: -1,
  name: "",
  type: 0,
  minimumToOrderInStock: 0,
  unitInStock: 0,
  useTaxes: false,
  taxesValue: 0,
  isFrozen: false,
  fixedUnitId: -1,
  unit1: -1,
);
const emptyCategory = ProductCategory(id: -1, name: "");
const emptyProductUnit = ProductUnit(
  isActive: false,
  id: -1,
  generalUnit: 0,
  purchasePrice: 0,
  salePrice: 0,
  box: 1,
  subTotal: 0,
  productId: -1,
);
