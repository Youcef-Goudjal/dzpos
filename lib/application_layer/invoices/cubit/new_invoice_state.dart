// ignore_for_file: constant_identifier_names

part of 'new_invoice_cubit.dart';

enum InvoiceState {
  New,
  Update;

  bool get isUpdating => this == InvoiceState.Update;
  bool get isNew => this == InvoiceState.New;
}

class NewInvoiceState extends Equatable {
  NewInvoiceState({
    FullInvoice? invoice,
    this.status = Status.initial,
    this.state = InvoiceState.New,
    this.save = false,
    this.msg,
  }) : invoice = invoice ?? FullInvoice.empty;
  final FullInvoice invoice;
  final bool save;
  final Status status;
  final InvoiceState state;
  final String? msg;

  @override
  List<Object?> get props => [
        invoice,
        status,
      ];

  NewInvoiceState copyWith({
    FullInvoice? invoice,
    bool? save,
    Status? status,
    InvoiceState? state,
    String? msg,
  }) =>
      NewInvoiceState(
        invoice: invoice ?? this.invoice,
        save: save ?? this.save,
        // status: status ?? this.status,
        msg: msg ?? this.msg,
        state: state ?? this.state,
      );
}
