import 'package:dzpos/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/manager/route/routes.dart';
import '../../../core/services/database.dart';
import '../../application_layer.dart';

class ListOfMaterialsPage extends StatelessWidget {
  const ListOfMaterialsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListOfProductsCubit(invoicesRepository),
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
    final listOfProductsCubit = context.read<ListOfProductsCubit>();
    return NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: const Text("Materials List"),
              actions: [
                BlocBuilder<ListOfProductsCubit, ListOfProductsState>(
                  builder: (context, state) {
                    if (state.status.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return IconButton(
                      onPressed: () {
                        showSearch(
                          context: context,
                          delegate: MaterialSearchDelegate(state.products),
                        );
                      },
                      icon: const Icon(Icons.search),
                    );
                  },
                ),
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
            BlocBuilder<ListOfProductsCubit, ListOfProductsState>(
              builder: (context, state) {
                if (state.status.isLoading) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      final product = state.products[index];

                      return Dismissible(
                        key: ValueKey(product.productId),
                        background: Container(color: context.error),
                        onDismissed: (direction) async {
                          final result = await showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Delete Product"),
                                content: Text(
                                    "Deleting product ${product.productId}"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, "No");
                                    },
                                    child: const Text("Cancel"),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: context.error,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context, "Yes");
                                    },
                                    child: Text(
                                      "Yes",
                                      style: context.textTheme.titleLarge!
                                          .copyWith(
                                        color: context.onError,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );

                          if (result == "Yes") {
                            listOfProductsCubit.deleteProduct(product);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            onTap: () {
                              context.pushNamed(
                                AppRoutes.product.name,
                                extra: product,
                              );
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide(
                                  color: context.primaryColor,
                                  width: 2,
                                )),
                            title: Text(product.productName),
                            subtitle: Row(
                              children: [
                                Text(
                                    "Units In stock ${product.unitInStock}\n category:${product.category.name}"),
                                const Spacer(),
                                Text(
                                    "price :${product.getUnit?.price ?? "0.0"}")
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
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
                  BlocBuilder<ListOfProductsCubit, ListOfProductsState>(
                    builder: (context, state) {
                      return Text(
                        "${state.products.length}",
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
  final List<FullProduct> materials;

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
    return ProductPage(product: materials[i]);
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
