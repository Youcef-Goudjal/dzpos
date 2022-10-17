part of 'show_invoices_cubit.dart';

class ShowInvoicesState extends Equatable {
  const ShowInvoicesState({
    this.status = Status.initial,
    this.invoices = const [],
    this.checkedInvoices = const {},
    this.msg,
  });
  final Status status;
  final List<FullInvoice> invoices;
  final Map<int, bool> checkedInvoices;
  final String? msg;
  @override
  List<Object> get props => [status, invoices, checkedInvoices];

  ShowInvoicesState copyWith({
    Status? status,
    List<FullInvoice>? invoices,
    Map<int, bool>? checkedInvoices,
    String? msg,
  }) {
    return ShowInvoicesState(
      status: status ?? Status.initial,
      invoices: invoices ?? this.invoices,
      checkedInvoices: checkedInvoices ?? this.checkedInvoices,
      msg: msg,
    );
  }
}
