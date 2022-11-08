import 'package:dzpos/core/extensions/extensions.dart';
import 'package:dzpos/data/repositories/repositories.dart';
import 'package:dzpos/domain/domain.dart';
import 'package:dzpos/product/product.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/enums.dart';
import '../../../core/manager/language/locale_keys.g.dart';
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
        Center(
          child: AspectRatio(
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
                      onPressed: () =>
                          InvoicesPages.values[index].onPressed(context),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            InvoicesPages.values[index].iconPath!,
                          ),
                          5.h.heightBox,
                          Text(InvoicesPages.values[index].name),
                        ],
                      ),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              2,
              (index) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: ElevatedButton(
                    onPressed: () =>
                        InvoicesPages.values[index + 2].onPressed(context),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          InvoicesPages.values[index + 2].iconPath!,
                        ),
                        5.h.heightBox,
                        Text(
                          InvoicesPages.values[index + 2].name,
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
        10.h.heightBox,
        ...List.generate(
          InvoicesPages.values.length - 4,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                alignment: Alignment.centerLeft,
              ),
              onPressed: () =>
                  InvoicesPages.values[index + 4].onPressed(context),
              child: Row(
                children: [
                  SvgPicture.asset(
                    InvoicesPages.values[index + 4].iconPath!,
                  ),
                  5.widthBox,
                  Expanded(
                    child: Text(InvoicesPages.values[index + 4].name),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

enum InvoicesPages {
  newSaleInvoice("New Sale Invoice", AppAssets.addShoppingCart), //
  newPurchaseInvoice("New Purchase Invoice", AppAssets.buying), //
  storeInventory("Store Inventory", AppAssets.trolley),
  returnedDamaged("Returned-Damaged", AppAssets.returnSvg),
  showInvoices("Show Invoices", AppAssets.check),
  totalDailyInvoicesReports("Total Daily Invoices Reports", AppAssets.invoice),
  activityOfTheMaterial("Activity Of The Material", AppAssets.masterCard),
  // editPrices("Edit Prices", AppAssets.editFile),
  pricingPolicy("Pricing Policy", AppAssets.coins),
  inventoryInvoice("Inventory Invoice", AppAssets.trolley),
  storeReconciliationAndRepair(
      "Store Reconciliation And Repair", AppAssets.maintenance),
  listOfMaterials("List Of Materials", AppAssets.box); //
  // barCodeDesigner("Barcode Designer", AppAssets.qrCode);

  String get name {
    switch (this) {
      case InvoicesPages.newSaleInvoice:
        return LocaleKeys.invoices_New_Sale_Invoice.tr();

      case InvoicesPages.newPurchaseInvoice:
        return LocaleKeys.invoices_New_Purchase_Invoice.tr();
      case InvoicesPages.storeInventory:
        return LocaleKeys.invoices_Store_Inventory.tr();
      case InvoicesPages.returnedDamaged:
        return LocaleKeys.invoices_ReturnedDamaged.tr();
      case InvoicesPages.showInvoices:
        return LocaleKeys.invoices_Show_Invoices.tr();
      case InvoicesPages.totalDailyInvoicesReports:
        return LocaleKeys.invoices_Total_Daily_Invoices_Reports.tr();
      case InvoicesPages.activityOfTheMaterial:
        return LocaleKeys.invoices_Activity_Of_The_Material.tr();
      // case Invoices.editPrices:
      //   return LocaleKeys.invoices_Edit_Prices.tr();
      case InvoicesPages.pricingPolicy:
        return LocaleKeys.invoices_Pricing_Policy.tr();
      case InvoicesPages.inventoryInvoice:
        return LocaleKeys.invoices_Inventory_Invoice.tr();
      case InvoicesPages.storeReconciliationAndRepair:
        return LocaleKeys.invoices_Store_Reconciliation_And_Repair.tr();
      case InvoicesPages.listOfMaterials:
        return LocaleKeys.invoices_List_Of_Materials.tr();
    }
  }

  final String n;
  final String? iconPath;

  const InvoicesPages(this.n, [this.iconPath]);

  void onPressed(BuildContext context) {
    switch (this) {
      case InvoicesPages.newSaleInvoice:
        context.pushNamed(
          AppRoutes.newInvoice.name,
          params: <String, String>{
            'type': InvoiceType.sell.name,
            'action': InvoiceActions.insert.index.toString(),
          },
        );
        break;

      case InvoicesPages.newPurchaseInvoice:
        context.pushNamed(
          AppRoutes.newInvoice.name,
          params: <String, String>{
            'type': InvoiceType.buy.name,
            'action': InvoiceActions.insert.index.toString(),
          },
        );
        break;
      case InvoicesPages.showInvoices:
        context.pushNamed(AppRoutes.showInvoices.name);
        break;
      case InvoicesPages.totalDailyInvoicesReports:
        context.pushNamed(AppRoutes.totalDailyInvoicesReports.name);
        break;
      case InvoicesPages.pricingPolicy:
        context.pushNamed(AppRoutes.pricingPolicy.name);
        break;
      case InvoicesPages.listOfMaterials:
        context.pushNamed(AppRoutes.listOfMaterials.name);
        break;

      case InvoicesPages.storeInventory:
      // context.pushNamed(AppRoutes.newSaleInvoice.name);
      // break;

      case InvoicesPages.returnedDamaged:
      // context.pushNamed(AppRoutes.newSaleInvoice.name);
      // break;

      case InvoicesPages.activityOfTheMaterial:
      // context.pushNamed(AppRoutes.newSaleInvoice.name);
      // break;

      // case Invoices.editPrices:
      // context.pushNamed(AppRoutes.newSaleInvoice.name);
      // break;

      case InvoicesPages.inventoryInvoice:
      // context.pushNamed(AppRoutes..name);
      // break;
      case InvoicesPages.storeReconciliationAndRepair:
      // context.pushNamed(AppRoutes.newSaleInvoice.name);
      // break;

      // case Invoices.barCodeDesigner:
      // break;
      default:
        statusHandler(context, Status.failure, msg: "Coming soon!!");
    }
  }
}
