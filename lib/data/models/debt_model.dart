import 'package:equatable/equatable.dart';

import '../../core/core.dart';
import '../data.dart';

class DebtModel extends Equatable {
  final Debt debt;
  final Account? account;
  final InvoiceModel? invoice;

  DebtModel({
    required this.debt,
    this.account,
    this.invoice,
  });

  @override
  List<Object?> get props => [debt, account, invoice];
}
