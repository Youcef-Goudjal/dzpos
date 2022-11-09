part of 'debt_cubit.dart';

class DebtState extends Equatable {
  const DebtState({
    this.debts = const [],
    this.viewPort = const [],
    this.status = Status.initial,
    this.type = true,
    this.amount = "",
    this.desc = "",
    this.accountId,
    this.msg,
    this.account,
    this.debtType = DeptType.invoice,
  });
  final bool type; // is payment??
  final DeptType debtType;
  final List<Debt> debts;
  final List<Debt> viewPort;
  final Status status;
  final String desc;
  final int? accountId;
  final String amount;
  final String? msg;
  final Account? account;

  double get total {
    double t = 0;
    debts.forEach((element) {
      if (element.isCredit) {
        t += element.amount;
      } else {
        t -= element.amount;
      }
    });
    return t;
  }

  @override
  List<Object?> get props =>
      [debts, status, type, desc, amount, accountId, debtType, account];
  DebtState copyWith({
    List<Debt>? debts,
    List<Debt>? viewPort,
    Status? status,
    bool? type,
    String? desc,
    String? amount,
    int? accountId,
    DeptType? debtType,
    String? msg,
    Account? account,
  }) =>
      DebtState(
        debts: debts ?? this.debts,
        status: status ?? Status.initial,
        type: type ?? this.type,
        desc: desc ?? this.desc,
        amount: amount ?? this.amount,
        accountId: accountId ?? this.accountId,
        msg: msg ?? this.msg,
        account: account ?? this.account,
        debtType: debtType ?? this.debtType,
        viewPort: viewPort ?? this.viewPort,
      );
}
