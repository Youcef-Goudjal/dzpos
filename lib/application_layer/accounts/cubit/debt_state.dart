part of 'debt_cubit.dart';

class DebtState extends Equatable {
  const DebtState({
    this.debts = const [],
    this.status = Status.initial,
    this.type = true,
    this.amount = "",
    this.desc = "",
    this.accountId,
    this.msg,
    this.account,
  });
  final bool type; // is payment??
  final List<Debt> debts;
  final Status status;
  final String desc;
  final int? accountId;
  final String amount;
  final String? msg;
  final Account? account;
  @override
  List<Object?> get props => [debts, status, type, desc, amount, accountId];
  DebtState copyWith({
    List<Debt>? debts,
    Status? status,
    bool? type,
    String? desc,
    String? amount,
    int? accountId,
    String? msg,
    Account? account,
  }) =>
      DebtState(
        debts: debts ?? this.debts,
        status: status ?? this.status,
        type: type ?? this.type,
        desc: desc ?? this.desc,
        amount: amount ?? this.amount,
        accountId: accountId ?? this.accountId,
        msg: msg ?? this.msg,
        account: account ?? this.account,
      );
}
