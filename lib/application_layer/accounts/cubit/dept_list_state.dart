part of 'dept_list_cubit.dart';

class DeptListState extends Equatable {
  const DeptListState({
    this.debts = const [],
    this.filteredList = const [],
    this.status = Status.initial,
  });

  final List<DebtModel> debts, filteredList;
  final Status status;
  @override
  List<Object> get props => [debts, status];

  DeptListState copyWith({
    List<DebtModel>? debts,
    List<DebtModel>? filteredList,
    Status? status,
  }) =>
      DeptListState(
        debts: debts ?? this.debts,
        status: status ?? this.status,
        filteredList: filteredList ?? this.filteredList,
      );
}
