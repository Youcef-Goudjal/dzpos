import 'dart:async';

import 'package:dzpos/application_layer/invoices/pages/pricing_policy_page.dart';
import 'package:dzpos/core/enums.dart';
import 'package:dzpos/core/services/database.dart';
import 'package:dzpos/data/repositories/repositories.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/manager/language/locale_keys.g.dart';

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
  PricingPolicyCubit() : super(const PricingPolicyState()){
    _repository.watchProducts.first.then((value) {
      emit(state.copyWith(
        products: value,
      ));
    });
  }

  void onPolicyChanged(PricingPolicy? value) {
    emit(state.copyWith(
      policy: value,
    ));
  }

  void onProductSelected(FullProduct value) {}

  void onPricingMethodChanged(PricingMethods? value) {
    emit(state.copyWith(
      method: value,
    ));
  }

  Future<Iterable<FullProduct>> suggestionCallback(String input) async {
    List<FullProduct> products = [];
    products.addAll(
      (await _repository.watchProducts.first).where(
        (element) => (element.productName.contains(input) ||
            element.categoryName.contains(input) ||
            (element.productCode?.contains(input) ?? false)),
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
}
