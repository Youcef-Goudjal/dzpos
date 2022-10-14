import 'package:dzpos/application_layer/application_layer.dart';
import 'package:dzpos/application_layer/invoices/cubit/product_cubit.dart';
import 'package:dzpos/core/extensions/extensions.dart';
import 'package:dzpos/core/services/database.dart';
import 'package:dzpos/data/models/product_model.dart';
import 'package:dzpos/product/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/enums.dart';

class ProductPage extends StatefulWidget {
  final ProductModel? product;
  const ProductPage({super.key, this.product});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit(),
      child: Builder(builder: (context) {
        return BlocListener<ProductCubit, ProductState>(
          listener: (context, state) {
            if (state.status == Status.failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: context.error,
                  content: const Text(
                    "Something went wrong !! \n product name or category not set",
                  ),
                ),
              );
            }
          },
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                context.read<ProductCubit>().saveProduct();
              },
              child: const Icon(Icons.save),
            ),
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    title: const Text("Product"),
                    bottom: TabBar(
                      controller: _tabController,
                      tabs: const [
                        Tab(
                          icon: Icon(Icons.home),
                          text: "Material info",
                        ),
                        Tab(
                          icon: Icon(Icons.qr_code_2_rounded),
                          text: "Units & Barcode",
                        ),
                      ],
                    ),
                  ),
                ];
              },
              body: TabBarView(
                controller: _tabController,
                children: const [
                  _ProductInfo(),
                  _UnitsBarcode(),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _UnitsBarcode extends StatelessWidget {
  const _UnitsBarcode({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productCubit = context.read<ProductCubit>();

    return ListView.separated(
      itemCount: productCubit.state.units.length + 1,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      itemBuilder: (context, index) {
        if (index >= productCubit.state.units.length) {
          return ElevatedButton(
            onPressed: () {
              // todo: add multiple units
            },
            child: const Text("Add new Unit"),
          );
        }
        return _ProductCard(
          index: index,
        );
      },
      separatorBuilder: (context, index) => 10.h.heightBox,
    );
  }
}

class _ProductCard extends StatelessWidget {
  final int index;
  const _ProductCard({
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset(AppAssets.barcode),
                10.w.widthBox,
                Expanded(
                  child: AppTextField(
                    hint: "Barcode",
                    // onChanged: productCubit.onCodeChanged,
                  ),
                ),
              ],
            ),
            10.h.heightBox,
            Row(
              children: [
                const Text("Price :"),
                10.w.widthBox,
                Expanded(
                  child: AppTextField(
                      // onChanged: productCubit.onPriceChanged,
                      ),
                ),
              ],
            ),
            10.h.heightBox,
            Row(
              children: [
                const Text("box:"),
                10.w.widthBox,
                Expanded(
                  child: AppTextField(
                      // onChanged: productCubit.onBoxChanged,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductInfo extends StatelessWidget {
  const _ProductInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productCubit = context.read<ProductCubit>();
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      children: [
        // AspectRatio(
        //   aspectRatio: 2,
        //   child: ElevatedButton(
        //     //TODO: select image
        //     onPressed: () {},
        //     child: SvgPicture.asset(
        //       AppAssets.unavailable,
        //       height: 100,
        //     ),
        //   ),
        // ),
        20.h.heightBox,
        BlocBuilder<ProductCubit, ProductState>(
          buildWhen: (previous, current) =>
              previous.productName != current.productName,
          builder: (context, state) {
            return AppTextField(
              hint: "Product name",
              onChanged: productCubit.onNameChanged,
            );
          },
        ),
        15.h.heightBox,
        Row(
          children: [
            const Text("Category :"),
            20.widthBox,
            FutureBuilder<List<ProductCategory>>(
              builder: (context, snapshot) {
                if (snapshot.connectionState.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final categories = snapshot.data!;
                return DropdownButton<ProductCategory>(
                  items: categories
                      .map((e) => DropdownMenuItem<ProductCategory>(
                          child: Text(e.name)))
                      .toList(),
                  onChanged: (value) {
                    productCubit.onCategorySelected(value!);
                  },
                );
              },
            ),
            10.w.widthBox,
            IconButton(
              onPressed: () async {
                final categoryName = await showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: StatefulBuilder(
                        builder: (context, setState) {
                          String categoryName = "";
                          return Column(
                            children: [
                              AppTextField(
                                onChanged: (input) {
                                  categoryName = input;
                                },
                              ),
                              10.heightBox,
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context, categoryName);
                                },
                                child: const Center(
                                  child: Text("Save"),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    );
                  },
                );
                productCubit.onCategoryChanged(categoryName);
                productCubit.saveCategory();
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        15.h.heightBox,
        Row(
          children: [
            const Text("unitInStock :"),
            20.widthBox,
            Expanded(
              child: AppTextField(
                onChanged: productCubit.onUnitInStockChanged,
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
