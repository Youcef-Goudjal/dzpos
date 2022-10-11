part of 'account_statement_cubit.dart';

class AccountStatementState extends Equatable {
  const AccountStatementState({
    this.account,
    this.date,
  });

  final dynamic account;
  final DateTimeRange? date;

  String get from =>
      "${date?.start.year}-${date?.start.month}-${date?.start.day}";
  String get to => "${date?.end.year}-${date?.end.month}-${date?.end.day}";

  @override
  List<Object?> get props => [account, date];
  AccountStatementState copyWith({
    dynamic account,
    DateTimeRange? date,
  }) =>
      AccountStatementState(
        account: account ?? this.account,
        date: date ?? this.date,
      );
}
