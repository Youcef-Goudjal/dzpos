import 'package:dzpos/core/extensions/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/manager/language/locale_keys.g.dart';
import '../../application_layer.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late final newInvoiceCubit = context.read<NewInvoiceCubit>();
  @override
  void initState() {
    newInvoiceCubit.loadProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.Products_List.tr()),
      ),
      body: BlocBuilder<NewInvoiceCubit, NewInvoiceState>(
        builder: (context, state) {
          final products = state.products;
          if (products.isEmpty) {
            return const EmptyBoxWidget();
          } else {
            return GridView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemBuilder: (context, index) {
                final product = products[index];
                bool isSelected = newInvoiceCubit.checkIfExist(product) != -1;
                final style = context.textTheme.bodySmall!.copyWith(
                  color: isSelected
                      ? context.colorScheme.onPrimaryContainer
                      : context.colorScheme.primary,
                );
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSelected
                        ? context.colorScheme.primaryContainer
                        : null,
                    elevation: isSelected ? 8 : 2,
                  ),
                  onPressed: () =>
                      newInvoiceCubit.toggleSaleWithProduct(product),
                  child: Center(
                      child: Column(
                    children: [
                      const Spacer(),
                      FittedBox(
                        child: Text(
                          product.productName,
                          style: context.textTheme.titleMedium!.copyWith(
                            color: isSelected
                                ? context.colorScheme.onPrimaryContainer
                                : context.colorScheme.primary,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FittedBox(
                            child: Text(
                              LocaleKeys.rest
                                  .tr(args: ["${product.unitInStock}"]),
                              style: style,
                            ),
                          ),
                          FittedBox(
                            child: Text(
                              "${product.getUnit?.price ?? "0.0"}DZ",
                              style: style,
                            ),
                          )
                        ],
                      )
                    ],
                  )),
                );
              },
            );
          }
        },
      ),
    );
  }
}
