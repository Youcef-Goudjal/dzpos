import 'dart:async';

import '../../../core/services/database.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/enums.dart';
import '../../../data/data.dart';
import '../../../domain/domain.dart';

part 'show_invoices_state.dart';

class ShowInvoicesCubit extends Cubit<ShowInvoicesState> {
  late StreamSubscription? _subscription;
  InvoicesRepository invoicesRepository;
  ShowInvoicesCubit(this.invoicesRepository)
      : super(const ShowInvoicesState(status: Status.loading)) {
    _subscription = invoicesRepository.watchAllInvoices.listen(
      (event) {
        emit(state.copyWith(
          invoices: event,
        ));
      },
      onError: (error) {
        emit(state.copyWith(
          status: Status.failure,
          msg: error.toString(),
        ));
      },
    );
  }

  void checkInvoice(int invoiceId, bool value) {
    var checkedInvoices = <int, bool>{};
    checkedInvoices.addAll(state.checkedInvoices);
    if (value) {
      checkedInvoices.putIfAbsent(invoiceId, () => true);
    } else {
      checkedInvoices.remove(invoiceId);
    }
    emit(
      state.copyWith(
        checkedInvoices: checkedInvoices,
      ),
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  void deleteInvoice(int index) async {
    try {
      await invoicesRepository.deleteInvoice(state.invoices[index]);
    } catch (e) {
      //
    }
  }

  void removeAllSelected() {
    invoicesRepository.deleteMultipleInvoices(
      state.checkedInvoices.keys.toList(),
    );
  }
}
