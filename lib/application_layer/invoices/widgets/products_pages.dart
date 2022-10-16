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
      body: GridView.builder(
        padding: const EdgeInsets.all(15),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
        itemBuilder: (context, index) {
          return ElevatedButton(
            onPressed: () {},
            child: Center(
              child: Text("$index"),
            ),
          );
        },
      ),
    );
  }
}
