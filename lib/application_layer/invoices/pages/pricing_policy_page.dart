import 'package:dzpos/core/extensions/extensions.dart';
import 'package:dzpos/core/services/database.dart';
import 'package:dzpos/product/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

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

    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  title: Text(LocaleKeys.invoices_Pricing_Policy.tr()),
                ),
                SliverList(
                  delegate: SliverChildListDelegate.fixed(
                    [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                            BlocBuilder<PricingPolicyCubit, PricingPolicyState>(
                          builder: (context, state) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: context.primaryColor),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topRight: 20.radius,
                                        topLeft: 20.radius,
                                      ),
                                      color:
                                          context.colorScheme.primaryContainer,
                                    ),
                                    child: const Center(
                                      child: Text("Pricing Method"),
                                    ),
                                  ),
                                  5.heightBox,
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: List.generate(
                                          PricingPolicy.values.length, (index) {
                                        return Expanded(
                                          child: RadioListTile(
                                            contentPadding: EdgeInsets.zero,
                                            visualDensity:
                                                VisualDensity.compact,
                                            value: PricingPolicy.values[index],
                                            title: Text(
                                              PricingPolicy.values[index].name,
                                              style: context
                                                  .textTheme.bodySmall!
                                                  .copyWith(
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            groupValue: state.policy,
                                            onChanged: cubit.onPolicyChanged,
                                          ),
                                        );
                                      })),
                                  5.heightBox,
                                  ...List.generate(
                                    PricingMethods.values.length,
                                    (index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: RadioListTile(
                                          contentPadding: EdgeInsets.zero,
                                          visualDensity: VisualDensity.compact,
                                          title: Text(PricingMethods
                                              .values[index].name),
                                          value: PricingMethods.values[index],
                                          groupValue: state.method,
                                          onChanged:
                                              cubit.onPricingMethodChanged,
                                        ),
                                      );
                                    },
                                  ),
                                  5.heightBox,
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TypeAheadWidget<FullProduct>(
                                            itemBuilder: (p0, value) {
                                              return ListTile(
                                                title: Text(value.productName),
                                                subtitle: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                        "${LocaleKeys.price.tr()} ${value.priceUnit}"),
                                                    Text(
                                                        "${LocaleKeys.Category.tr()} ${value.categoryName}"),
                                                  ],
                                                ),
                                              );
                                            },
                                            onSuggestionSelected:
                                                cubit.onProductSelected,
                                            suggestionCallback:
                                                cubit.suggestionCallback,
                                          ),
                                        ),
                                        5.widthBox,
                                        ElevatedButton(
                                          onPressed: () {}, //TODO; scan code
                                          child: Center(
                                            child: SvgPicture.asset(
                                                AppAssets.barcodeScanner),
                                          ),
                                        ),
                                        5.widthBox,
                                      ],
                                    ),
                                  ),
                                  5.heightBox,
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: AppTextField(
                                            isDense: true,
                                            hint: LocaleKeys.modification_Value
                                                .tr(),
                                            onChanged: cubit
                                                .onModificationValueChanged,
                                          ),
                                        ),
                                        5.widthBox,
                                        Checkbox(
                                          value: state.usePercentage,
                                          onChanged:
                                              cubit.onCheckPercentageToggled,
                                        ),
                                        5.widthBox,
                                        ElevatedButton(
                                          onPressed: cubit.applyModification,
                                          child: Text(
                                            LocaleKeys.apply.tr(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  5.heightBox,
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
          body: BlocBuilder<PricingPolicyCubit, PricingPolicyState>(
            buildWhen: (previous, current) =>
                previous.products != current.products,
            builder: (context, state) {
              final products = state.products;
              if (state.status.isLoading) {
                return Center(
                  child: Lottie.asset(AppAssets.loadingLottie),
                );
              }
              if (products.isEmpty) {
                return Center(
                  child: Lottie.asset(AppAssets.emptyBoxLottie),
                );
              }
              return ListView.separated(
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Card(
                    child: ListTile(
                      title: Center(
                        child: Column(
                          children: [
                            Text(product.productName),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Center(
                                  child: Text(
                                      "${LocaleKeys.price.tr()} ${product.priceUnit}"),
                                ),
                                Center(
                                  child: Text(
                                      "${LocaleKeys.rest.tr()} ${product.unitInStock}"),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        if (state.policy == PricingPolicy.fixed) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    5.heightBox,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Center(
                                          child: Text(
                                              LocaleKeys.price_purchase.tr()),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  );
                },
                separatorBuilder: (context, index) => 10.heightBox,
                itemCount: state.products.length,
              );
            },
          )),
    );
  }
}
