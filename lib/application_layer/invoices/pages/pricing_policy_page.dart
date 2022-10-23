import 'package:dzpos/application_layer/invoices/pages/invoices_page.dart';
import 'package:dzpos/application_layer/widgets/type_ahead_widget.dart';
import 'package:dzpos/core/extensions/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/manager/language/locale_keys.g.dart';
import '../../../core/services/database.dart';

enum PricingPolicy {
  last,
  fixed,
  lastAccount;

  String get name {
    switch (this) {
      case PricingPolicy.fixed:
        return LocaleKeys.Fixed_Price.tr();
      case PricingPolicy.last:
        return LocaleKeys.Last_sale_price.tr();
      case PricingPolicy.lastAccount:
        return LocaleKeys.last_account_operation.tr();
    }
  }

  bool get isLast => this == PricingPolicy.last;
  bool get isFixed => this == PricingPolicy.fixed;
  bool get isLastAccount => this == PricingPolicy.lastAccount;
}

class PricingPolicyPage extends StatelessWidget {
  const PricingPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    const policy = PricingPolicy.fixed;
    return Column(
      children: [
        Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: RadioListTile(
                    value: PricingPolicy.last,
                    title: Text(PricingPolicy.last.name),
                    groupValue: policy,
                    onChanged: (value) {},
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    value: PricingPolicy.fixed,
                    title: Text(PricingPolicy.fixed.name),
                    groupValue: policy,
                    onChanged: (value) {},
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    value: PricingPolicy.lastAccount,
                    title: Text(PricingPolicy.lastAccount.name),
                    groupValue: policy,
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
            15.heightBox,
            TypeAheadWidget<Product>(
              suggestionCallback: (input) async {
                return invoicesRepository.getProducts;
              },
              itemBuilder: (context, product) {
                return ListTile(
                  title: Text(product.name),
                );
              },
              onSuggestionSelected: (product) {},
            )
          ],
        )
      ],
    );
  }
}
