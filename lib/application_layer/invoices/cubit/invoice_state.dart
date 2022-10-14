part of 'invoice_cubit.dart';

class InvoiceState extends Equatable {
  const InvoiceState({
    required this.id,
    this.account,
    this.amountTrended = 0,
    this.total = 0,
    this.date,
  });

  final DateTime? date;
  final int id;
  final Account? account;
  final double total, amountTrended;

  @override
  List<Object?> get props => [id, account, amountTrended, total, date];
}
