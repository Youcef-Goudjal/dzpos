import 'package:dzpos/application_layer/application_layer.dart';
import 'package:dzpos/core/extensions/extensions.dart';
import 'package:dzpos/product/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProductPage extends StatefulWidget {
  final String? title;
  const ProductPage({super.key, this.title});

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
    return Scaffold(
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
                  child: AppTextField(),
                ),
              ],
            ),
            10.h.heightBox,
            Row(
              children: [
                const Text("Sale Price :"),
                10.w.widthBox,
                Expanded(
                  child: AppTextField(),
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
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      children: [
        AspectRatio(
          aspectRatio: 2,
          child: ElevatedButton(
            onPressed: () {},
            child: SvgPicture.asset(
              AppAssets.unavailable,
              height: 100,
            ),
          ),
        ),
        20.h.heightBox,
        AppTextField(
          hint: "Product name",
        ),
        15.h.heightBox,
        Row(
          children: [
            const Text("Category :"),
            20.widthBox,
            Expanded(child: AppTextField()),
          ],
        ),
        15.h.heightBox,
        Row(
          children: [
            const Text("Minimum :"),
            20.widthBox,
            Expanded(child: AppTextField()),
          ],
        ),
      ],
    );
  }
}
