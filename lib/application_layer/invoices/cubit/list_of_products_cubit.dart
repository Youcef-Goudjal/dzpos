import 'dart:async';

import 'package:dzpos/core/enums.dart';
import 'package:dzpos/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/database.dart';

part 'list_of_products_state.dart';

class ListOfProductsCubit extends Cubit<ListOfProductsState> {
  late StreamSubscription? _subscription;
  InvoicesRepository invoicesRepository;
  ListOfProductsCubit(this.invoicesRepository)
      : super(const ListOfProductsState(status: Status.loading)) {
    _subscription = invoicesRepository.watchProducts.listen((event) {
      emit(state.copyWith(
        products: event,
        status: Status.success,
      ));
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  deleteProduct(FullProduct product) {
    invoicesRepository.deleteProduct(product.productId);
  }
}
