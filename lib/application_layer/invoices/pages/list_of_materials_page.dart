import 'package:dzpos/application_layer/invoices/cubit/list_of_products_cubit.dart';
import 'package:dzpos/application_layer/invoices/invoices.dart';
import 'package:dzpos/core/extensions/extensions.dart';
import 'package:dzpos/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/manager/route/routes.dart';
import '../../../core/services/database.dart';

class ListOfMaterialsPage extends StatelessWidget {
  const ListOfMaterialsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListOfProductsCubit(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.pushNamed(AppRoutes.product.name);
          },
          child: const Icon(Icons.add),
        ),
        body: const _MaterialsBody(),
      ),
    );
  }
}

class _MaterialsBody extends StatelessWidget {
  const _MaterialsBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: const Text("Materials List"),
              actions: [
                StreamBuilder<List<Product>>(
                    stream: context.read<ListOfProductsCubit>().wachMaterials(),
                    builder: (context, snapshot) {
                      return IconButton(
                        onPressed: () {
                          showSearch(
                            context: context,
                            delegate:
                                MaterialSearchDelegate(snapshot.data ?? []),
                          );
                        },
                        icon: const Icon(Icons.search),
                      );
                    }),
              ],
            )
          ];
        },
        body: Column(
          children: [
            10.h.heightBox,
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  10.w.widthBox,
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: context.theme.colorScheme.primary),
                      onPressed: () {},
                      child: Center(
                        child: Text(
                          "Import from an Excel",
                          style: TextStyle(
                            color: context.theme.colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                        ),
                      ),
                    ),
                  ),
                  10.w.widthBox,
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: context.theme.colorScheme.secondary),
                      onPressed: () {},
                      child: Center(
                        child: Text(
                          "Export to Excel",
                          style: TextStyle(
                            color: context.theme.colorScheme.onSecondary,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                        ),
                      ),
                    ),
                  ),
                  10.w.widthBox,
                ],
              ),
            ),
            StreamBuilder<List<Product>>(
              stream: context.read<ListOfProductsCubit>().wachMaterials(),
              builder: (context, state) {
                if (state.hasData) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.data!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(state.data![index].productName),
                        );
                      },
                    ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            Container(
              decoration: BoxDecoration(
                color: context.theme.colorScheme.primaryContainer,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Number of results:  ",
                    style: TextStyle(
                      color: context.theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                  StreamBuilder<List<Product>>(
                    stream: context.read<ListOfProductsCubit>().wachMaterials(),
                    builder: (context, state) {
                      return Text(
                        "${state.data?.length ?? 0}",
                        style: TextStyle(
                          color: context.theme.colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

class MaterialSearchDelegate extends SearchDelegate {
  final List<Product> materials;

  MaterialSearchDelegate(this.materials);
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = "";
          }
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ProductPage(product: ProductModel(product: materials[i]));
  }

  int i = 0;
  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions =
        materials.where((element) => element.productName.contains(query));
    return ListView.builder(
      itemCount: query.isEmpty ? materials.length : suggestions.length,
      itemBuilder: (context, index) {
        final name = query.isEmpty
            ? materials[index].productName
            : suggestions.elementAt(index).productName;
        return ListTile(
          title: Text(name),
          onTap: () {
            query = name;
            i = index;
            showResults(context);
          },
        );
      },
    );
  }
}
