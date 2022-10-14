part of 'new_account_cubit.dart';

class NewAccountState extends Equatable {
  const NewAccountState({
    this.status = Status.initial,
    this.accountType = AccountType.none,
    this.name = "",
    this.contact = "",
    this.address = "",
    this.code = "",
    this.id = "",
    this.email = "",
    this.msg,
  });
  final String id;
  final Status status;
  final AccountType accountType;
  final String code;
  final String name;
  final String contact;
  final String address;
  final String email;
  final String? msg;

  @override
  List<Object> get props => [
        id,
        status,
        accountType,
        name,
        contact,
        address,
        code,
        email,
      ];

  NewAccountState copyWith({
    Status? status,
    String? id,
    AccountType? accountType,
    String? name,
    String? code,
    String? contact,
    String? address,
    String? email,
    String? msg,
  }) =>
      NewAccountState(
        id: id ?? this.id,
        status: status ?? this.status,
        address: address ?? this.address,
        contact: contact ?? this.contact,
        accountType: accountType ?? this.accountType,
        name: name ?? this.name,
        code: code ?? this.code,
        email: email ?? this.email,
        msg: msg,
      );
}
