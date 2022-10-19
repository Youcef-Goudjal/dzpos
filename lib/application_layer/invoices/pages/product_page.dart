import 'package:dzpos/application_layer/auth/utils.dart';
import 'package:dzpos/core/extensions/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/manager/language/locale_keys.g.dart';
import '../../../core/services/database.dart';
import '../../../product/product.dart';
import '../../application_layer.dart';

class ProductPage extends StatefulWidget {
  final FullProduct? product;
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
      create: (context) => ProductCubit(product: widget.product),
      child: Builder(builder: (context) {
        return BlocListener<ProductCubit, ProductState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            statusHandler(context, state.status, msg: state.msg);
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
                    title: Text(LocaleKeys.Product.tr()),
                    bottom: TabBar(
                      controller: _tabController,
                      tabs: [
                        Tab(
                          icon: const Icon(Icons.home),
                          text: LocaleKeys.Material_info.tr(),
                        ),
                        Tab(
                          icon: const Icon(Icons.qr_code_2_rounded),
                          text: LocaleKeys.Units_Barcode.tr(),
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

    return BlocBuilder<ProductCubit, ProductState>(
      buildWhen: (previous, current) =>
          previous.product.unitsList != current.product.unitsList,
      builder: (context, state) {
        return ListView.separated(
          itemCount: productCubit.state.product.unitsList.length + 1,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          itemBuilder: (context, index) {
            if (index >= productCubit.state.product.unitsList.length) {
              return ElevatedButton(
                onPressed: productCubit.addEmptyUnit,
                child: Text(LocaleKeys.Add_new_Unit.tr()),
              );
            }
            return _ProductCard(
              index: index,
            );
          },
          separatorBuilder: (context, index) => 10.h.heightBox,
        );
      },
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
    final productCubit = context.read<ProductCubit>();
    final unit = productCubit.state.product.unitsList[index];
    return Stack(
      children: [
        Card(
          elevation: 8,
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
                        initialValue: unit.code,
                        hint: "Barcode",
                        onChanged: (input) {
                          productCubit.onCodeUnitUpdated(index, input);
                        },
                      ),
                    ),
                  ],
                ),
                10.h.heightBox,
                Row(
                  children: [
                    Text(LocaleKeys.price.tr()),
                    10.w.widthBox,
                    Expanded(
                      child: AppTextField(
                        initialValue: "${unit.price}",
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        onChanged: (input) {
                          productCubit.onPriceUnitUpdated(index, input);
                        },
                      ),
                    ),
                  ],
                ),
                10.h.heightBox,
                Row(
                  children: [
                    Text(LocaleKeys.box.tr()),
                    10.w.widthBox,
                    Expanded(
                      child: AppTextField(
                        initialValue: unit.box.toString(),
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        onChanged: (input) {
                          productCubit.onBoxUnitUpdated(index, input);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              backgroundColor: context.error,
              alignment: Alignment.center,
            ),
            onPressed: () {
              productCubit.removeUnit(index);
            },
            child: Icon(
              Icons.delete_forever,
              color: context.onError,
            ),
          ),
        )
      ],
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
              previous.product.productName != current.product.productName,
          builder: (context, state) {
            return AppTextField(
              initialValue: state.product.productName,
              hint: LocaleKeys.Product_name.tr(),
              onChanged: productCubit.onNameChanged,
            );
          },
        ),
        15.h.heightBox,
        Row(
          children: [
            Text(LocaleKeys.Category.tr()),
            20.widthBox,
            Expanded(
              child: StreamBuilder<List<ProductCategory>>(
                stream: invoicesRepository.watchCategories,
                builder: (context, snapshot) {
                  if (snapshot.connectionState.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final categories = snapshot.data!;

                  if (categories.isEmpty) {
                    return Text(LocaleKeys.No_category_found.tr());
                  }
                  productCubit.onCategorySelected(categories.first);
                  return BlocBuilder<ProductCubit, ProductState>(
                    buildWhen: (previous, current) =>
                        previous.product.category != current.product.category,
                    builder: (context, state) {
                      return DropdownButton<ProductCategory>(
                        isExpanded: true,
                        value: state.product.category,
                        items: categories
                            .map(
                              (e) => DropdownMenuItem<ProductCategory>(
                                value: e,
                                child: Text(e.name),
                              ),
                            )
                            .toList(),
                        onChanged: productCubit.onCategorySelected,
                      );
                    },
                  );
                },
              ),
            ),
            10.w.widthBox,
            IconButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: StatefulBuilder(
                        builder: (context, setState) {
                          return Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppTextField(
                                  onChanged: productCubit.onCategoryChanged,
                                ),
                                10.heightBox,
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Center(
                                    child: Text(LocaleKeys.Save.tr()),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
                productCubit.saveCategory();
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        15.h.heightBox,
        Row(
          children: [
            Text(LocaleKeys.unitInStock.tr()),
            20.widthBox,
            Expanded(
              child: AppTextField(
                initialValue: "${productCubit.state.product.unitInStock}",
                onChanged: productCubit.onUnitInStockChanged,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
