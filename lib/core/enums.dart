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
  sell,
  buy;

  String get name {
    switch (this) {
      case InvoiceType.buy:
        return "Purchase";
      case InvoiceType.sell:
        return "Sell";
    }
  }

  static InvoiceType stringToType(String type) {
    switch (type) {
      case "Purchase":
        return InvoiceType.buy;
      case "Sell":
        return InvoiceType.sell;
      default:
        return InvoiceType.sell;
    }
  }
}

enum InvoiceActions { update, insert }
