import 'package:equatable/equatable.dart';

import '../../core/enums.dart';
import 'entities.dart';

class InvoiceEntity extends Equatable {
  final int? id;
  final CustomerEntity? customer;
  final PaymentType? paymentType;
  final double? totalAmount;
  final double? amountTendered;
  final DateTime? dateRecorded;
  final UserEntity? user;

  const InvoiceEntity({
    this.id,
    this.customer,
    this.paymentType,
    this.totalAmount,
    this.amountTendered,
    this.dateRecorded,
    this.user,
  });
  @override
  List<Object?> get props => [
        id,
        customer,
        paymentType,
        totalAmount,
        amountTendered,
        dateRecorded,
        user,
      ];
}
