import 'package:dzpos/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InvoicesPage extends StatelessWidget {
  const InvoicesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 2,
          child: Row(
            children: List.generate(
              2,
              (index) => ElevatedButton(
                onPressed: () {},
                child: Text(Invoices.values[index].name),
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
              (index) => ElevatedButton(
                onPressed: () {},
                child: Text(Invoices.values[index].name),
              ),
            ),
          ),
        ),
        20.h.heightBox,
        ListView.separated(
          itemCount: Invoices.values.length - 4,
          itemBuilder: (context, index) {
            return TextButton(
              onPressed: () {},
              child: Text(Invoices.values[index + 4].name),
            );
          },
          separatorBuilder: (context, index) {
            return 20.h.heightBox;
          },
        ),
      ],
    );
  }
}

enum Invoices {
  newSaleInvoice("New Sale Invoice"),
  newPurchaseInvoice("New Purchase Invoice"),
  storeInventory("Store Inventory"),
  returnedDamaged("Returned-Damaged"),
  showInvoices("Show Invoices"),
  totalDailyInvoicesReports("Total Daily Invoices Reports"),
  activityOfTheMaterial("Activity Of The Material"),
  editPrices("Edit Prices"),
  pricingPolicy("Pricing Policy"),
  inventoryInvoice("Inventory Invoice"),
  storeReconciliationAndRepair("Store Reconciliation And Repair"),
  listOfMaterials("List Of Materials"),
  barCodeDesigner("Barcode Designer");

  final String name;

  const Invoices(this.name);

  void onPressed(BuildContext context) {}
}
