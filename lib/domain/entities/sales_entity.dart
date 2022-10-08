import 'package:equatable/equatable.dart';

import 'entities.dart';

class SalesEntity extends Equatable {
  final int? id;
  final InvoiceEntity? invoice;
  final ProductEntity? product;
  final double? quantity;
  final double? unitPrice;

  const SalesEntity({
    this.id,
    this.invoice,
    this.product,
    this.quantity,
    this.unitPrice,
  });

  double get subTotal {
    double total = 0.0;
    if (quantity == null || unitPrice == null) {
      return total;
    }
    total = quantity! * unitPrice!;
    return total;
  }

  @override
  List<Object?> get props => [
        id,
        invoice,
        product,
        quantity,
        unitPrice,
      ];
}
