part of 'account_statement_cubit.dart';

class AccountStatementState extends Equatable {
  const AccountStatementState({
    required this.account,
    this.debts = const [],
    this.date,
    this.status = Status.initial,
    this.msg,
  });

  final Account account;
  final List<Debt> debts;
  final DateTimeRange? date;
  final Status status;
  final String? msg;

  String get from =>
      "${date?.start.year}-${date?.start.month}-${date?.start.day}";
  String get to => "${date?.end.year}-${date?.end.month}-${date?.end.day}";

  @override
  List<Object?> get props => [account, date, debts];
  AccountStatementState copyWith({
    Account? account,
    DateTimeRange? date,
    List<Debt>? debts,
    Status? status,
    String? msg,
  }) =>
      AccountStatementState(
        account: account ?? this.account,
        date: date ?? this.date,
        debts: debts ?? this.debts,
        status: status ?? this.status,
        msg: msg ?? this.msg,
      );
}
