import 'package:dzpos/core/extensions/extensions.dart';
import 'package:dzpos/core/services/database.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/manager/language/locale_keys.g.dart';
import '../../application_layer.dart';

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
    return BlocProvider(
      create: (context) => PricingPolicyCubit(),
      child: const _PricingPolicyBody(),
    );
  }
}

class _PricingPolicyBody extends StatelessWidget {
  const _PricingPolicyBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PricingPolicyCubit>();
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          BlocBuilder<PricingPolicyCubit, PricingPolicyState>(
            builder: (context, state) {
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: context.primaryColor)),
                child: Column(
                  children: [
                    Container(
                      height: 20,
                      decoration: BoxDecoration(
                        color: context.colorScheme.primaryContainer,
                      ),
                      child: Text(
                        LocaleKeys.invoices_Pricing_Policy.tr(),
                        style: context.textTheme.titleLarge!.copyWith(
                          color: context.colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                    10.heightBox,
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile(
                            value: PricingPolicy.last,
                            title: Text(PricingPolicy.last.name),
                            groupValue: state.policy,
                            onChanged: cubit.onPolicyChanged,
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            value: PricingPolicy.fixed,
                            title: Text(PricingPolicy.fixed.name),
                            groupValue: state.policy,
                            onChanged: cubit.onPolicyChanged,
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            value: PricingPolicy.lastAccount,
                            title: Text(PricingPolicy.lastAccount.name),
                            groupValue: state.policy,
                            onChanged: cubit.onPolicyChanged,
                          ),
                        ),
                      ],
                    ),
                    ...List.generate(PricingMethods.values.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RadioListTile(
                          value: PricingMethods.values[index],
                          groupValue: state.method,
                          onChanged: cubit.onPricingMethodChanged,
                          title: Text(PricingMethods.values[index].name),
                        ),
                      );
                    }),
                    15.heightBox,
                    TypeAheadWidget<FullProduct>(
                      suggestionCallback: cubit.suggestionCallback,
                      itemBuilder: (context, product) {
                        return ListTile(
                          title: Text(product.productName),
                          subtitle: Text(product.categoryName),
                        );
                      },
                      onSuggestionSelected: cubit.onProductSelected,
                    ),
                    5.heightBox,
                    Row(
                      children: [
                        Expanded(
                          child: AppTextField(
                            hint: LocaleKeys.modification_Value.tr(),
                            onChanged: cubit.onModificationValueChanged,
                          ),
                        ),
                        5.widthBox,
                        CheckboxListTile(
                          value: true,
                          onChanged: cubit.onCheckPercentageToggled,
                        ),
                        5.widthBox,
                        ElevatedButton(
                          onPressed: cubit.applyModification,
                          child: Text(LocaleKeys.apply.tr()),
                        ),
                      ],
                    ),
                    5.heightBox,
                  ],
                ),
              );
            },
          )
        ];
      },
      body: BlocBuilder<PricingPolicyCubit, PricingPolicyState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.products.isEmpty) {
            return Center(
              child: Text(LocaleKeys.No_Product_Fount.tr()),
            );
          }
          return ListView.separated(
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              final product = state.products[index];
              return InkWell(
                onTap: () {},
                child: Card(
                  elevation: 5,
                  child: Column(
                    children: [
                      Center(child: Text(product.productName)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("${product.purchasePrice}"),
                          Text("${product.priceUnit}"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(LocaleKeys.last_purchase.tr()),
                          Text(LocaleKeys.profit.tr()),
                          Text(LocaleKeys.profitRatio.tr()),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => 10.heightBox,
          );
        },
      ),
    );
  }
}
