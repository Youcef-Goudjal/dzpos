import 'package:dzpos/core/extensions/extensions.dart';
import 'package:dzpos/core/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application_layer.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final newInvoiceCubit = context.read<NewInvoiceCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Products List"),
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
              return const Center(
                child: Text("No Product Fount"),
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
                    final style = context.textTheme.titleMedium!.copyWith(
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
                          Text(
                            product.productName,
                            style: style,
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Text(
                                "rest: $index",
                                style: style,
                              ), //TODO: calucalte rest
                              const Spacer(),
                              Text(
                                "${product.getUnit?.price ?? "0.0"}DZ",
                                style: style,
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
