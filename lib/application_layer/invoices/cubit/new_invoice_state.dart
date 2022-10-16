part of 'new_invoice_cubit.dart';

class NewInvoiceState extends Equatable {
  const NewInvoiceState({
    required this.id,
    required this.account,
    this.amountTrended = 0,
    this.total = 0,
    this.date,
    this.sales = const [],
    this.status = Status.initial,
    this.msg,
  });

  final DateTime? date;
  final int id;
  final double total, amountTrended;
  final Account account;
  final List<SalesCompanion> sales;
  final Status status;
  final String? msg;

  @override
  List<Object?> get props => [
        id,
        amountTrended,
        total,
        date,
        sales,
        status,
      ];

  NewInvoiceState copyWith({
    DateTime? date,
    Account? account,
    int? id,
    double? total,
    double? amountTrended,
    List<SalesCompanion>? sales,
    Status? status,
    String? msg,
  }) =>
      NewInvoiceState(
        id: id ?? this.id,
        account: account ?? this.account,
        amountTrended: amountTrended ?? this.amountTrended,
        total: total ?? this.total,
        date: date ?? this.date,
        sales: sales ?? this.sales,
        status: status ?? this.status,
        msg: msg ?? this.msg,
      );
}
