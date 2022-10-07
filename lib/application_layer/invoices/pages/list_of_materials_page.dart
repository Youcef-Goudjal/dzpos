import 'package:dzpos/application_layer/invoices/invoices.dart';
import 'package:dzpos/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/manager/route/routes.dart';

class ListOfMaterialsPage extends StatelessWidget {
  const ListOfMaterialsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(AppRoutes.product.name);
        },
        child: const Icon(Icons.add),
      ),
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: const Text("Materials List"),
                actions: [
                  IconButton(
                    onPressed: () {
                      showSearch(
                        context: context,
                        delegate: MaterialSearchDelegate([]),
                      );
                    },
                    icon: const Icon(Icons.search),
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
                            backgroundColor:
                                context.theme.colorScheme.secondary),
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
              Expanded(child: ListView()),
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
                    Text(
                      "10",
                      style: TextStyle(
                        color: context.theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}

class MaterialSearchDelegate extends SearchDelegate {
  final List materials;

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
    return ProductPage(title: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
      // itemCount: materials.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text("$index"),
          onTap: () {
            query = "$index";
            showResults(context);
          },
        );
      },
    );
  }
}
