import 'package:dzpos/application_layer/widgets/app_text_field.dart';
import 'package:dzpos/core/extensions/extensions.dart';
import 'package:flutter/material.dart';

class PrintLabels extends StatelessWidget {
  const PrintLabels({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Printer Labels"),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return Row(
            children: [
              Expanded(
                flex: 3,
                child: AppTextField(
                  initialValue: PrinterLabels.values[index].name,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Edit",
                  style: TextStyle(color: Colors.green),
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
  product,
  quantity,
  unit,
  subTotal1,
  subTotal2,
  notes,
  totalQuantity,
  net,
  discount,
  add,
  total,
  amountTreated;

  String get name {
    switch (this) {
      case PrinterLabels.invoice:
        return "فاتورة";
      case PrinterLabels.product:
        return "اسم المادة";
      case PrinterLabels.quantity:
        return "الكمية";
      case PrinterLabels.unit:
        return "الوحدة";
      case PrinterLabels.subTotal1:
        return "الإفرادي";
      case PrinterLabels.subTotal2:
        return "الإجمالي";
      case PrinterLabels.notes:
        return "ملاحظات";
      case PrinterLabels.totalQuantity:
        return "مجموع الكمية";
      case PrinterLabels.net:
        return "الصافي";
      case PrinterLabels.discount:
        return "الخصم";
      case PrinterLabels.add:
        return "اضافة";
      case PrinterLabels.total:
        return "مجموع الفاتورة";
      case PrinterLabels.amountTreated:
        return "دفعة نقدية";
      default:
        return "";
    }
  }
}
