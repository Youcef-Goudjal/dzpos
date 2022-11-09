import 'package:easy_localization/easy_localization.dart';

import 'core.dart';

enum Status {
  initial,
  success,
  loading,
  info,
  failure;

  bool get isInitial => this == Status.initial;
  bool get isFailure => this == Status.failure;
  bool get isSuccess => this == Status.success;
  bool get isLoading => this == Status.loading;
}

enum PaymentType { cache, credit }

enum UserType { admin, cashier, inventory }

enum InvoiceType {
  sales,
  purchase,
  damage,
  salesReturn,
  purchaseReturn;

  String get name {
    switch (this) {
      case InvoiceType.purchase:
        return "Purchase";
      case InvoiceType.sales:
        return "Sell";
      case InvoiceType.damage:
        return "Damage";
      case InvoiceType.purchaseReturn:
        return "Purchase Return";
      case InvoiceType.salesReturn:
        return "Sell Return";
    }
  }

  bool get isSales => InvoiceType.sales == this;
  bool get isPurchase => InvoiceType.purchase == this;
  bool get isDamage => InvoiceType.damage == this;
  bool get isSalesReturn => InvoiceType.salesReturn == this;
  bool get isPurchaseReturn => InvoiceType.purchaseReturn == this;
  bool get isSalesOrSalesReturn => isSales || isSalesReturn;
  bool get isPurchaseOrPurchaseReturn => isPurchase || isPurchaseReturn;

  static InvoiceType stringToType(String type) {
    switch (type) {
      case "Purchase":
        return InvoiceType.purchase;
      case "Sell":
        return InvoiceType.sales;
      default:
        return InvoiceType.sales;
    }
  }
}

enum InvoiceActions { update, insert }

enum UnitType { sell, buy }

enum GeneralUnits { Piece, box, package, g, Kg, ton, meter }

enum AccountType {
  customer,
  supplier,
  none,
  both;

  String get name {
    switch (this) {
      case AccountType.customer:
        return LocaleKeys.Customer.tr();
      case AccountType.supplier:
        return LocaleKeys.Supplier.tr();
      case AccountType.both:
        return LocaleKeys.Customer.tr() + " " + LocaleKeys.Supplier.tr();
      default:
        return "none";
    }
  }
}

enum DeptType {
  old,
  invoice,
}

enum PricingPolicy {
  last,
  fixed,
  lastAccount;

  String get name {
    switch (this) {
      case PricingPolicy.fixed:
        return LocaleKeys.Fixed_Price.tr();
      case PricingPolicy.last:
        return LocaleKeys.Last_sale_price.tr();
      case PricingPolicy.lastAccount:
        return LocaleKeys.last_account_operation.tr();
    }
  }

  bool get isLast => this == PricingPolicy.last;
  bool get isFixed => this == PricingPolicy.fixed;
  bool get isLastAccount => this == PricingPolicy.lastAccount;
}

enum PrintTableValues {
  ID,
  Item,
  Box,
  Price,
  Quantity,
  Total;

  /// [with] is the width of the column in Thermal printers
  /// must the total equals 12
  int get width {
    switch (this) {
      case PrintTableValues.ID:
        return 1;
      case PrintTableValues.Item:
        return 3;
      case PrintTableValues.Box:
        return 1;
      case PrintTableValues.Price:
        return 2;
      case PrintTableValues.Quantity:
        return 2;
      case PrintTableValues.Total:
        return 3;
    }
  }
}
