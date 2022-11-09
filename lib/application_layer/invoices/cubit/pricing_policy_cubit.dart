import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/enums.dart';
import '../../../core/manager/language/locale_keys.g.dart';
import '../../../data/data.dart';
import '../../../product/product.dart';

part 'pricing_policy_state.dart';

enum PricingMethods {
  increaseProfitMarginBasedOnCostPrice,
  increaseCurrentSellingPrice,
  decreaseCurrentSalesPrice,
  increaseCurrentPurchasePrice,
  decreaseCurrentPurchasePrice,
  ;

  String get name {
    switch (this) {
      case PricingMethods.increaseProfitMarginBasedOnCostPrice:
        return LocaleKeys.increase_profit_margin_based_on_cost_price.tr();
      case PricingMethods.increaseCurrentSellingPrice:
        return LocaleKeys.increase_current_selling_price.tr();
      case PricingMethods.decreaseCurrentSalesPrice:
        return LocaleKeys.Decrease_current_sales_price.tr();
      case PricingMethods.increaseCurrentPurchasePrice:
        return LocaleKeys.Increase_current_purchase_price.tr();
      case PricingMethods.decreaseCurrentPurchasePrice:
        return LocaleKeys.Decrease_current_purchase_price.tr();
    }
  }
}

class PricingPolicyCubit extends Cubit<PricingPolicyState> {
  final _repository = InvoicesRepositoryImpl();
  StreamSubscription? _subscription;
  PricingPolicyCubit()
      : super(const PricingPolicyState(status: Status.loading)) {
    emit(
      state.copyWith(
        method:
            PricingMethods.values[StorageKeys.pricingMethod.storedValue ?? 0],
        policy:
            PricingPolicy.values[StorageKeys.pricingPolicy.storedValue ?? 1],
      ),
    );
    _subscription = _repository.watchProducts.listen((value) {
      emit(state.copyWith(
        products: value,
      ));
    });
  }

  void onPolicyChanged(PricingPolicy? value) {
    if (value != null) {
      StorageKeys.pricingPolicy.setValue(value.index);
      emit(state.copyWith(
        policy: value,
      ));
    }
  }

  void onProductSelected(ProductModel value) {}

  void onPricingMethodChanged(PricingMethods? value) {
    if (value != null) {
      StorageKeys.pricingMethod.setValue(value.index);
      emit(state.copyWith(
        method: value,
      ));
    }
  }

  Future<Iterable<ProductModel>> suggestionCallback(String input) async {
    List<ProductModel> products = [];
    products.addAll(
      (await _repository.watchProducts.first).where(
        (element) => (element.productName.contains(input) ||
            element.categoryName.contains(input)),
      ),
    );
    emit(state.copyWith(
      products: products,
    ));
    return products;
  }

  void onModificationValueChanged(String input) {
    final value = double.tryParse(input);

    emit(state.copyWith(
      modificationValue: value,
    ));
  }

  void onCheckPercentageToggled(bool? value) {
    emit(state.copyWith(
      usePercentage: value,
    ));
  }

  void applyModification() {
    //TODO: apply modification
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
