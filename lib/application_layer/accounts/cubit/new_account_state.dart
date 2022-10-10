part of 'new_account_cubit.dart';

class NewAccountState extends Equatable {
  const NewAccountState({
    this.status = Status.initial,
    this.isCustomer = true,
    this.name = "",
    this.contact = "",
    this.address = "",
    this.code = "",
    this.id = "",
  });
  final String id;
  final Status status;
  final bool isCustomer;
  final String code;
  final String name;
  final String contact;
  final String address;

  @override
  List<Object> get props => [
        id,
        status,
        isCustomer,
        name,
        contact,
        address,
        code,
      ];

  NewAccountState copyWith({
    Status? status,
    String? id,
    bool? isCustomer,
    String? name,
    String? code,
    String? contact,
    String? address,
  }) =>
      NewAccountState(
        id: id ?? this.id,
        status: status ?? this.status,
        address: address ?? this.address,
        contact: contact ?? this.contact,
        isCustomer: isCustomer ?? this.isCustomer,
        name: name ?? this.name,
        code: code ?? this.code,
      );
}
