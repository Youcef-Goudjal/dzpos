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
    switch (this) {
      case PrinterLabels.invoice:
        return storedValue ?? "فاتورة";
        case PrinterLabels.invoiceId:
        return storedValue ?? " رقم الفاتورة";
      case PrinterLabels.product:
        return storedValue ?? "اسم المادة";
      case PrinterLabels.quantity:
        return storedValue ?? "الكمية";
      case PrinterLabels.unit:
        return storedValue ?? "الوحدة";
      case PrinterLabels.subTotal1:
        return storedValue ?? "الإفرادي";
      case PrinterLabels.subTotal2:
        return storedValue ?? "الإجمالي";
      case PrinterLabels.notes:
        return storedValue ?? "ملاحظات";
      case PrinterLabels.totalQuantity:
        return storedValue ?? "مجموع الكمية";
      case PrinterLabels.net:
        return storedValue ?? "الصافي";
      case PrinterLabels.discount:
        return storedValue ?? "الخصم";
      case PrinterLabels.add:
        return storedValue ?? "اضافة";
      case PrinterLabels.total:
        return storedValue ?? "مجموع الفاتورة";
      case PrinterLabels.amountTreated:
        return storedValue ?? "دفعة نقدية";
      case PrinterLabels.date:
        return storedValue ?? "تاريخ الفاتورة";
      case PrinterLabels.time:
        return storedValue ?? "وقت الفاتورة";
      case PrinterLabels.mr:
        return storedValue ?? "السيد";
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
          PrinterLabels.values.map((e) => "").toList(),
    );
    list.insert(index, value);
    Application.pref.setStringList(StorageKeys.printLabels.name, list);
  }
}
