import 'package:dzpos/application_layer/widgets/app_text_field.dart';
import 'package:dzpos/core/extensions/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/manager/language/locale_keys.g.dart';
import '../../../product/product.dart';

class PrintLabels extends StatelessWidget {
  const PrintLabels({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.Printer_Labels.tr()),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return Row(
            children: [
              Expanded(
                flex: 3,
                child: AppTextField(
                  initialValue: PrinterLabels.values[index].value,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  LocaleKeys.Edit.tr(),
                  style: const TextStyle(color: Colors.green),
                ),
              ),
            ],
          );
        },
        separatorBuilder: (context, index) => 10.heightBox,
        itemCount: PrinterLabels.values.length,
      ),
    );
  }
}

enum PrinterLabels {
  invoice,
  invoiceId,
  product,
  quantity,
  unit,
  subTotal1,
  subTotal2,
  notes,
  totalQuantity,
  net,
  discount,
  date,
  time,
  add,
  total,
  mr,
  amountTreated;

  String get value {
    return storedValue ?? name;
  }

  String get name {
    switch (this) {
      case PrinterLabels.invoice:
        return storedValue ?? "invoice";
      case PrinterLabels.invoiceId:
        return storedValue ?? "invoice ID";
      case PrinterLabels.product:
        return storedValue ?? "product";
      case PrinterLabels.quantity:
        return storedValue ?? "quantity";
      case PrinterLabels.unit:
        return storedValue ?? "unit";
      case PrinterLabels.subTotal1:
        return storedValue ?? "subTotal";
      case PrinterLabels.subTotal2:
        return storedValue ?? "total";
      case PrinterLabels.notes:
        return storedValue ?? "notes";
      case PrinterLabels.totalQuantity:
        return storedValue ?? "Total Quantity";
      case PrinterLabels.net:
        return storedValue ?? "net";
      case PrinterLabels.discount:
        return storedValue ?? "discount";
      case PrinterLabels.add:
        return storedValue ?? "add";
      case PrinterLabels.total:
        return storedValue ?? "Total facture";
      case PrinterLabels.amountTreated:
        return storedValue ?? "Amount treated";
      case PrinterLabels.date:
        return storedValue ?? "date Facture";
      case PrinterLabels.time:
        return storedValue ?? "time:";
      case PrinterLabels.mr:
        return storedValue ?? "Mr.";
      default:
        return "";
    }
  }

  String? get storedValue {
    return Application.pref
        .getStringList(StorageKeys.printLabels.name)
        ?.elementAt(index);
  }

  void storeValue(String value) {
    List<String> list = [];
    list.addAll(
      Application.pref.getStringList(StorageKeys.printLabels.name) ??
          PrinterLabels.values.map((e) => e.name).toList(),
    );
    list.insert(index, value);
    Application.pref.setStringList(StorageKeys.printLabels.name, list);
  }
}
