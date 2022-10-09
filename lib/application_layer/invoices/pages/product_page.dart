import 'package:dzpos/application_layer/application_layer.dart';
import 'package:dzpos/application_layer/invoices/cubit/product_cubit.dart';
import 'package:dzpos/core/extensions/extensions.dart';
import 'package:dzpos/data/models/product_model.dart';
import 'package:dzpos/product/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../../core/services/database.dart';

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
        return Scaffold(
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
    return ListView.separated(
      itemCount: 1,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      itemBuilder: (context, index) => const _ProductCard(),
      separatorBuilder: (context, index) => 10.h.heightBox,
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productCubit = context.read<ProductCubit>();
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
                    onChanged: productCubit.onCodeChanged,
                  ),
                ),
              ],
            ),
            10.h.heightBox,
            Row(
              children: [
                const Text("Purchase Price :"),
                10.w.widthBox,
                Expanded(
                  child: AppTextField(
                    onChanged: productCubit.onPurchasePriceChanged,
                  ),
                ),
              ],
            ),
            10.h.heightBox,
            Row(
              children: [
                const Text("Sale Price :"),
                10.w.widthBox,
                Expanded(
                  child: AppTextField(
                    onChanged: productCubit.onSalePriceChanged,
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
        AspectRatio(
          aspectRatio: 2,
          child: ElevatedButton(
            //TODO: select image
            onPressed: () {},
            child: SvgPicture.asset(
              AppAssets.unavailable,
              height: 100,
            ),
          ),
        ),
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
            StreamBuilder<List<ProductCategory>>(
              stream: productCubit.allCategories(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                return Expanded(
                  child: TypeAheadField<ProductCategory>(
                    autoFlipDirection: true,
                    suggestionsCallback: (pattern) {
                      productCubit.onCategoryChanged(pattern);
                      if (pattern.isEmpty) {
                        return snapshot.data!;
                      }
                      return snapshot.data!.where(
                          (element) => element.categoryName.contains(pattern));
                    },
                    itemBuilder: (context, item) {
                      return ListTile(
                        title: Text(item.categoryName),
                      );
                    },
                    noItemsFoundBuilder: (context) {
                      return const Text("No item found");
                    },
                    onSuggestionSelected: productCubit.onCategorySelected,
                  ),
                );
              },
            ),
            10.w.widthBox,
            IconButton(
              onPressed: () {
                productCubit.saveCategory();
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        15.h.heightBox,
        Row(
          children: [
            const Text("Minimum :"),
            20.widthBox,
            Expanded(
              child: AppTextField(
                onChanged: productCubit.onMinimChanged,
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
