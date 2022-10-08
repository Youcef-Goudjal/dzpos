import 'package:equatable/equatable.dart';

class SupplierEntity extends Equatable {
  final int? id;
  final String? code;
  final String? name;
  final String? contact;
  final String? address;
  final String? email;

  const SupplierEntity({
    this.id,
    this.code,
    this.name,
    this.contact,
    this.address,
    this.email,
  });
  @override
  List<Object?> get props => [
        id,
        code,
        name,
        contact,
        address,
        email,
      ];
}
