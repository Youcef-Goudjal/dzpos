part of 'accounts_list_cubit.dart';

class AccountsListState extends Equatable {
  const AccountsListState({
    this.customers = const [],
    this.suppliers = const [],
    this.status = Status.initial,
  });

  final List<Customer> customers;
  final List<Supplier> suppliers;
  final Status status;

  @override
  List<Object> get props => [customers, suppliers, status];

  AccountsListState copyWith({
    List<Customer>? customers,
    List<Supplier>? suppliers,
    Status? status,
  }) =>
      AccountsListState(
        customers: customers ?? this.customers,
        status: status ?? this.status,
        suppliers: suppliers ?? this.suppliers,
      );
}
