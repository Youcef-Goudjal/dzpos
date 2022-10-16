import 'package:dzpos/application_layer/invoices/invoices.dart';
import 'package:dzpos/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/enums.dart';
import '../../../core/services/database.dart';

part 'new_invoice_state.dart';

class NewInvoiceCubit extends Cubit<NewInvoiceState> {
  final InvoicesRepository invoicesRepository;
  InvoiceType type;
  NewInvoiceCubit({
    required int invoiceId,
    required Account account,
    required this.type,
    required this.invoicesRepository,
  }) : super(NewInvoiceState(
          id: invoiceId,
          account: account,
        ));

  void addProduct(FullProduct product) {
    final sales = state.sales;
    sales.add(SalesCompanion.insert(
      invoiceId: state.id,
      productId: product.productId,
      unitId: 0,
      quantity: 1,
      unitPrice: product.getUnit?.price ?? 0,
    ));
    emit(state.copyWith(
      sales: sales,
    ));
  }
}
