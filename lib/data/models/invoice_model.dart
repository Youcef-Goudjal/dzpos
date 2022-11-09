import 'package:equatable/equatable.dart';

import '../../core/core.dart';
import '../data.dart';

class InvoiceModel extends Equatable {
  final Invoice invoice;
  final List<SaleModel> sales;
  final Account account;

  InvoiceModel(this.invoice, this.sales, this.account);

  // getters
  int get invoiceId => invoice.id;
  int get accountId => invoice.accountId;
  InvoiceType get invoiceType => invoice.invoiceType;
  PaymentType get paymentType => invoice.paymentType;
  double? get totalAmount => invoice.totalAmount;
  double get amountTendered => invoice.amountTendered;
  DateTime get dateRecorded => invoice.dateRecorded;
  String get accountName => account.name;

  double get total {
    double t = 0;
    if (invoiceType.isPurchaseOrPurchaseReturn) {
      for (SaleModel sale in sales) {
        t += sale.purchaseSubTotal;
      }
    } else {
      for (SaleModel sale in sales) {
        t += sale.saleSubTotal;
      }
    }
    return t;
  }

  double get totalQuantity {
    double q = 0;
    for (SaleModel sale in sales) {
      q += sale.quantity;
    }
    return q;
  }

  bool get isAccountEmpty => account == emptyAccount;

  bool get isInvoiceEmpty => invoice == emptyInvoice;

  InvoiceModel copyWith({
    Invoice? invoice,
    List<SaleModel>? sales,
    Account? account,
  }) =>
      InvoiceModel(
        invoice ?? this.invoice,
        sales ?? this.sales,
        account ?? this.account,
      );
  @override
  List<Object?> get props => [invoice, sales, account];

  static final empty = InvoiceModel(emptyInvoice, [], emptyAccount);
  bool get isEmpty => this == empty;
  bool get isNotEmpty => !isEmpty;
}

final emptyInvoice = Invoice(
  id: -1,
  accountId: -1,
  paymentType: PaymentType.cache,
  invoiceType: InvoiceType.sales,
  totalAmount: 0,
  amountTendered: 0,
  discountAmount: 0,
  net: 0,
);
