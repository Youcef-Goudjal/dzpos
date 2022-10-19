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
  listOfMaterials("List Of Materials", AppAssets.box); //
  // barCodeDesigner("Barcode Designer", AppAssets.qrCode);

  String get name {
    switch (this) {
      case Invoices.newSaleInvoice:
        return LocaleKeys.invoices_New_Sale_Invoice.tr();

      case Invoices.newPurchaseInvoice:
        return LocaleKeys.register_TermsCondition.tr();
      case Invoices.storeInventory:
        return LocaleKeys.invoices_New_Purchase_Invoice.tr();
      case Invoices.returnedDamaged:
        return LocaleKeys.invoices_ReturnedDamaged.tr();
      case Invoices.showInvoices:
        return LocaleKeys.invoices_Show_Invoices.tr();
      case Invoices.totalDailyInvoicesReports:
        return LocaleKeys.invoices_Total_Daily_Invoices_Reports.tr();
      case Invoices.activityOfTheMaterial:
        return LocaleKeys.invoices_Activity_Of_The_Material.tr();
      case Invoices.editPrices:
        return LocaleKeys.invoices_Edit_Prices.tr();
      case Invoices.pricingPolicy:
        return LocaleKeys.invoices_Pricing_Policy.tr();
      case Invoices.inventoryInvoice:
        return LocaleKeys.invoices_Inventory_Invoice.tr();
      case Invoices.storeReconciliationAndRepair:
        return LocaleKeys.invoices_Store_Reconciliation_And_Repair.tr();
      case Invoices.listOfMaterials:
        return LocaleKeys.invoices_List_Of_Materials.tr();
    }
  }

  final String n;
  final String? iconPath;

  const Invoices(this.n, [this.iconPath]);

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

      case Invoices.showInvoices:
        context.pushNamed(AppRoutes.showInvoices.name);
        break;
      case Invoices.storeInventory:
      // context.pushNamed(AppRoutes.newSaleInvoice.name);
      // break;

      case Invoices.returnedDamaged:
      // context.pushNamed(AppRoutes.newSaleInvoice.name);
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

      // case Invoices.barCodeDesigner:
      // break;
      default:
        statusHandler(context, Status.failure, msg: "Coming soon!!");
    }
  }
}
