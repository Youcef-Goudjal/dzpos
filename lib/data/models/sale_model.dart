import 'package:equatable/equatable.dart';

import '../../core/core.dart';
import '../../product/constants/constants.dart';
import '../data.dart';

class SaleModel extends Equatable {
  final Sale sale;
  final ProductModel product;

  const SaleModel(this.sale, this.product);

  // getters
  int get saleId => sale.salesId;
  int get productId => sale.productId;
  String get productName => product.productName;
  int get invoiceId => sale.invoiceId;
  double get quantity => sale.quantity;
  ProductUnit get unit => product.getUnitById(sale.unitId);

  double get salePrice => unit.salePrice;
  double get purchasePrice => unit.purchasePrice;

  double get box {
    final useBox = StorageKeys.settingsUseBox.storedValue ?? false;
    return useBox ? unit.box : 1;
  }

  // functions
  //TODO: subTotal need more time
  /// [saleSubTotal] called when invoice.sale
  double get saleSubTotal {
    return quantity * salePrice * box;
  }

  /// [purchaseSubTotal] called when invoice.buy
  double get purchaseSubTotal {
    return quantity * purchasePrice * box;
  }

  /// get print values
  /// return [String]
  /// input [PrintTableValues]
  String getIndex(PrintTableValues col,
      {InvoiceType type = InvoiceType.sales}) {
    final useBox = StorageKeys.settingsUseBox.storedValue ?? false;
    double box = useBox ? product.boxUnit : 1;
    switch (col) {
      case PrintTableValues.ID:
        return "$productId";
      case PrintTableValues.Item:
        return "$productName";
      case PrintTableValues.Box:
        return "$box";
      case PrintTableValues.Price:
        if (type.isPurchaseOrPurchaseReturn)
          return formatCurrency(purchasePrice);
        return formatCurrency(salePrice);
      case PrintTableValues.Quantity:
        return "$quantity";
      case PrintTableValues.Total:
        if (type.isPurchaseOrPurchaseReturn) return "$purchasePrice";
        return "$saleSubTotal";
    }
  }

  SaleModel copyWith({
    Sale? sale,
    ProductModel? product,
  }) =>
      SaleModel(
        sale ?? this.sale,
        product ?? this.product,
      );

  @override
  List<Object?> get props => [sale, product];

  //
  static const empty = SaleModel(emptySale, ProductModel.empty);
  bool get isEmpty => this == empty;
  bool get isNotEmpty => !isEmpty;
}

const emptySale = Sale(
  salesId: -1,
  invoiceId: -1,
  productId: -1,
  unitId: -1,
  quantity: 0,
  unitPrice: 0,
  subTotal: 0,
);
