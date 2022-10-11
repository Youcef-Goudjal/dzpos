part of 'accounts_list_cubit.dart';

class AccountsListState extends Equatable {
  const AccountsListState({
    this.accounts = const [],
    this.status = Status.initial,
  });

  final List<Account> accounts;

  final Status status;

  @override
  List<Object> get props => [accounts, status];

  AccountsListState copyWith({
    List<Account>? accounts,
    Status? status,
  }) =>
      AccountsListState(
        accounts: accounts ?? this.accounts,
        status: status ?? this.status,
      );
}
