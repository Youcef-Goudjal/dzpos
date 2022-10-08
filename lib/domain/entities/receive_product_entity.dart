import 'package:equatable/equatable.dart';

import 'entities.dart';

class ReceiveProductEntity extends Equatable {
  final int? id;
  final ProductEntity? product;
  final double? quantity;
  final double? unitPrice;
  final DateTime? receivedDate;
  final UserEntity? user;

  double get subTotal {
    double total = 0.0;
    if (quantity == null || unitPrice == null) {
      return total;
    }
    total = quantity! * unitPrice!;
    return total;
  }

  const ReceiveProductEntity({
    this.id,
    this.product,
    this.quantity,
    this.unitPrice,
    this.receivedDate,
    this.user,
  });
  @override
  List<Object?> get props => [
        id,
        product,
        quantity,
        unitPrice,
        receivedDate,
        user,
      ];
}
