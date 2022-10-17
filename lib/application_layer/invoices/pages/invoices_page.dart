import 'package:dzpos/application_layer/application_layer.dart';
import 'package:dzpos/core/extensions/extensions.dart';
import 'package:dzpos/data/repositories/repositories.dart';
import 'package:dzpos/domain/domain.dart';
import 'package:dzpos/product/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/enums.dart';
import '../../../core/manager/route/routes.dart';
import '../../auth/utils.dart';

final InvoicesRepository invoicesRepository = InvoicesRepositoryImpl();

class InvoicesPage extends StatelessWidget {
  const InvoicesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _InvoiceBody();
  }
}

class _InvoiceBody extends StatelessWidget {
  const _InvoiceBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 15.h,
      ),
      children: [
        AspectRatio(
          aspectRatio: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(
              2,
              (index) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: ElevatedButton(
                    onPressed: () => Invoices.values[index].onPressed(context),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          Invoices.values[index].iconPath!,
                        ),
                        5.h.heightBox,
                        Text(Invoices.values[index].name),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        20.h.heightBox,
        AspectRatio(
          aspectRatio: 2,
          child: Row(
            children: List.generate(
              2,
              (index) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: ElevatedButton(
                    onPressed: () =>
                        Invoices.values[index + 2].onPressed(context),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          Invoices.values[index + 2].iconPath!,
                        ),
                        5.h.heightBox,
                        Text(
                          Invoices.values[index + 2].name,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        20.h.heightBox,
        ...List.generate(
          Invoices.values.length - 4,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                alignment: Alignment.centerLeft,
              ),
              onPressed: () => Invoices.values[index + 4].onPressed(context),
              icon: SvgPicture.asset(
                Invoices.values[index + 4].iconPath!,
              ),
              label: Text(Invoices.values[index + 4].name),
            ),
          ),
        )
      ],
    );
  }
}

enum Invoices {
  newSaleInvoice("New Sale Invoice", AppAssets.addShoppingCart), //
  newPurchaseInvoice("New Purchase Invoice", AppAssets.buying), //
  storeInventory("Store Inventory", AppAssets.trolley),
  returnedDamaged("Returned-Damaged", AppAssets.returnSvg),
  showInvoices("Show Invoices", AppAssets.check),
  totalDailyInvoicesReports("Total Daily Invoices Reports", AppAssets.invoice),
  activityOfTheMaterial("Activity Of The Material", AppAssets.masterCard),
  editPrices("Edit Prices", AppAssets.editFile),
  pricingPolicy("Pricing Policy", AppAssets.coins),
  inventoryInvoice("Inventory Invoice", AppAssets.trolley),
  storeReconciliationAndRepair(
      "Store Reconciliation And Repair", AppAssets.maintenance),
  listOfMaterials("List Of Materials", AppAssets.box), //
  barCodeDesigner("Barcode Designer", AppAssets.qrCode);

  final String name;
  final String? iconPath;

  const Invoices(this.name, [this.iconPath]);

  void onPressed(BuildContext context) {
    switch (this) {
      case Invoices.newSaleInvoice:
        context.pushNamed(
          AppRoutes.newInvoice.name,
          params: <String, String>{'type': InvoiceType.sell.name},
        );
        break;

      case Invoices.newPurchaseInvoice:
        context.pushNamed(
          AppRoutes.newInvoice.name,
          params: <String, String>{'type': InvoiceType.buy.name},
        );
        break;
      case Invoices.listOfMaterials:
        context.pushNamed(AppRoutes.listOfMaterials.name);
        break;

      case Invoices.storeInventory:
      // context.pushNamed(AppRoutes.newSaleInvoice.name);
      // break;

      case Invoices.returnedDamaged:
      // context.pushNamed(AppRoutes.newSaleInvoice.name);
      // break;

      case Invoices.showInvoices:
      // context.pushNamed(AppRoutes..name);
      // break;
      case Invoices.totalDailyInvoicesReports:
      // context.pushNamed(AppRoutes.newSaleInvoice.name);
      // break;

      case Invoices.activityOfTheMaterial:
      // context.pushNamed(AppRoutes.newSaleInvoice.name);
      // break;

      case Invoices.editPrices:
      // context.pushNamed(AppRoutes.newSaleInvoice.name);
      // break;

      case Invoices.pricingPolicy:
      // context.pushNamed(AppRoutes.newSaleInvoice.name);
      // break;

      case Invoices.inventoryInvoice:
      // context.pushNamed(AppRoutes..name);
      // break;
      case Invoices.storeReconciliationAndRepair:
      // context.pushNamed(AppRoutes.newSaleInvoice.name);
      // break;

      case Invoices.barCodeDesigner:
      // break;
      default:
        statusHandler(context, Status.failure, msg: "Coming soon!!");
    }
  }
}
