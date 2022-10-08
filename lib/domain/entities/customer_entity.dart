import 'package:equatable/equatable.dart';

class CustomerEntity extends Equatable {
  final int? id;
  final String? code;
  final String? name;
  final String? contact;
  final String? address;

  const CustomerEntity({
    this.id,
    this.code,
    this.name,
    this.contact,
    this.address,
  });
  @override
  List<Object?> get props => [
        id,
        code,
        name,
        contact,
        address,
      ];
}
