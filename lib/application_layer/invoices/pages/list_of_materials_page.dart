import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/core.dart';
import '../../../data/data.dart';
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
              title: Text(LocaleKeys.invoices_List_Of_Materials.tr()),
              actions: [
                BlocBuilder<ListOfProductsCubit, ListOfProductsState>(
                  builder: (context, state) {
                    if (state.status.isLoading) {
                      return const LoadingWidget();
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
                      onPressed: listOfProductsCubit.importFromExcel,
                      child: Center(
                        child: Text(
                          LocaleKeys.Import_from_an_Excel.tr(),
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
                      onPressed: listOfProductsCubit.exportFromExcel,
                      child: Center(
                        child: Text(
                          LocaleKeys.Export_to_Excel.tr(),
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
                  return const LoadingWidget();
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
                          final result = await confirmDeleteDialog(context,
                              msg:
                                  "${LocaleKeys.deleting.tr()} ${product.productName}");
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
                                Text(LocaleKeys.Units_In_stock_category_name.tr(
                                    args: [
                                      "${product.unitInStock}",
                                      (product.categoryName)
                                    ])),
                                const Spacer(),
                                Text(
                                    //TODO: change the price depending if the invoice is sale or purchase
                                    "${LocaleKeys.price.tr()} ${formatCurrency(product.salePriceUnit)}")
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
                    LocaleKeys.Number_of_results.tr(),
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
  final List<ProductModel> materials;

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
