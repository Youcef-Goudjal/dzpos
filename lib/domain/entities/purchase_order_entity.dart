import 'package:dzpos/domain/entities/entities.dart';
import 'package:equatable/equatable.dart';

class PurchaseOrderEntity extends Equatable {
  final int? id;
  final ProductEntity? product;
  final double? quantity;
  final double? unitPrice;
  final DateTime? orderDate;
  final UserEntity? user;

  double get subTotal {
    double total = 0.0;
    if (quantity == null || unitPrice == null) {
      return total;
    }
    total = quantity! * unitPrice!;
    return total;
  }

  const PurchaseOrderEntity({
    this.id,
    this.product,
    this.quantity,
    this.unitPrice,
    this.orderDate,
    this.user,
  });
  @override
  List<Object?> get props => [
        id,
        product,
        quantity,
        unitPrice,
        orderDate,
        user,
      ];
}
