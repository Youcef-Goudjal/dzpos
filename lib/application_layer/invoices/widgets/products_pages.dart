import 'package:dzpos/core/extensions/extensions.dart';
import 'package:dzpos/core/services/database.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/manager/language/locale_keys.g.dart';
import '../../application_layer.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final newInvoiceCubit = context.read<NewInvoiceCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.Products_List.tr()),
      ),
      body: StreamBuilder<List<FullProduct>>(
          stream: invoicesRepository.watchProducts,
          builder: (context, snapshot) {
            if (snapshot.connectionState.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final products = snapshot.data!;
            if (products.isEmpty) {
              return Center(
                child: Text(LocaleKeys.No_Product_Fount.tr()),
              );
            }
            return BlocBuilder<NewInvoiceCubit, NewInvoiceState>(
              builder: (context, state) {
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
                    bool isSelected =
                        newInvoiceCubit.checkIfExist(product) != -1;
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
              },
            );
          }),
    );
  }
}
