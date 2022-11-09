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
    InvoiceModel? invoice,
    this.status = Status.initial,
    this.state = InvoiceState.New,
    this.save = false,
    this.products = const [],
    InvoiceType? type,
    this.msg,
  })  : invoice = invoice ?? InvoiceModel.empty,
        type = type ?? InvoiceType.sales;
  final InvoiceModel invoice;
  final bool save;
  final Status status;
  final InvoiceState state;
  final InvoiceType type;
  final String? msg;
  final List<ProductModel> products;

  @override
  List<Object?> get props => [
        invoice,
        status,
        save,
        state,
        products,
      ];

  NewInvoiceState copyWith({
    InvoiceModel? invoice,
    bool? save,
    Status? status,
    InvoiceState? state,
    String? msg,
    List<ProductModel>? products,
    InvoiceType? type,
  }) {
    return NewInvoiceState(
      invoice: invoice ?? this.invoice,
      save: save ?? this.save,
      status: status ?? Status.initial,
      msg: msg,
      products: products ?? this.products,
      state: state ?? this.state,
      type: type ?? this.type,
    );
  }
}
