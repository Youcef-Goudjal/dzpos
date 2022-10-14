part of 'dept_list_cubit.dart';

class DeptListState extends Equatable {
  const DeptListState({
    this.debts = const [],
    this.filteredList = const [],
    this.status = Status.initial,
  });

  final List<DebtWithAccount> debts, filteredList;
  final Status status;
  @override
  List<Object> get props => [debts, status];

  DeptListState copyWith({
    List<DebtWithAccount>? debts,
    List<DebtWithAccount>? filteredList,
    Status? status,
  }) =>
      DeptListState(
        debts: debts ?? this.debts,
        status: status ?? this.status,
        filteredList: filteredList ?? this.filteredList,
      );
}
