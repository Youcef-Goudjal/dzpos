import 'package:esc_pos_utils_plus/esc_pos_utils.dart';
import 'package:image/image.dart';

import '../../../application_layer/settings/pages/labels_page.dart';
import '../../../data/data.dart';
import '../../../product/product.dart';
import '../../enums.dart';
import '../../utils/utils.dart';

Future<List<int>> buildThermal(
    CapabilityProfile profile, PaperSize paper, InvoiceModel invoice) async {
  final generator = Generator(paper, profile);
  generator.setStyles(
    const PosStyles.defaults(
      // codeTable: "CP1256",
      align: PosAlign.center,
    ),
  );
  List<int> bytes = [];
  bytes.addAll(_buildHeader(generator, invoice));
  bytes.addAll(generator.hr());
  bytes.addAll(_contentHeader(generator, invoice));
  bytes.addAll(generator.hr());
  bytes.addAll(_contentTable(generator, invoice));
  bytes.addAll(generator.hr());
  bytes.addAll(_contentFooter(generator, invoice));
  bytes.addAll(generator.cut());
  return bytes;
}

/// displays the total price
Iterable<int> _contentFooter(Generator generator, InvoiceModel invoice) {
  List<int> bytes = [];
  bytes.addAll(generator.text("Total Quantity: ${invoice.totalQuantity}"));
  bytes.addAll([
    if (invoice.paymentType == PaymentType.credit)
      ...generator.text(
        "total invoice: ${formatCurrency(invoice.total)} \n" +
            "Amount Treated : ${formatCurrency(invoice.amountTendered)}",
      ),
    // Total
    ...generator.text("Total : ${formatCurrency(invoice.total)}",
        styles: const PosStyles.defaults(
          align: PosAlign.center,
          bold: true,
        )),
    ...generator.hr(),
    //Date and time
    if (StorageKeys.showPrintDateAndTime.storedValue ?? true)
      ...generator.text(formatDate(invoice.dateRecorded)),
    // Bottom Invoice
    if (StorageKeys.showBottomInvoice.storedValue ?? false)
      ...generator.text(StorageKeys.bottomInvoice.storedValue ?? ""),
  ]);

  return bytes;
}

/// display the sales table + total Quantity
Iterable<int> _contentTable(Generator generator, InvoiceModel invoice) {
  List<int> bytes = [];

  bytes.addAll(
    generator.row(
      List.generate(
        PrintTableValues.values.length,
        (index) => PosColumn(
          text: PrintTableValues.values[index].name,
          width: PrintTableValues.values[index].width,
        ),
      ),
    ),
  );
  bytes.addAll(generator.hr());
  for (SaleModel sale in invoice.sales) {
    bytes.addAll([
      ...generator.row(
        List.generate(
          PrintTableValues.values.length,
          (index) => PosColumn(
            text: sale.getIndex(PrintTableValues.values[index]),
            width: PrintTableValues.values[index].width,
          ),
        ),
      ),
      // ...generator.hr(),
    ]);
  }

  return bytes;
}

/// displays the header of the content
/// content {invoiceId,date and time}
Iterable<int> _contentHeader(Generator generator, InvoiceModel invoice) {
  List<int> bytes = [];
  bytes += generator.text(
    "${PrinterLabels.invoiceId.value}: ${invoice.invoiceId}",
  );
  bytes += generator.text(
    "${PrinterLabels.date.value} : ${dateToYMD(invoice.dateRecorded)}",
  );
  bytes += generator.text(
    "${PrinterLabels.date.value} : ${getTime(invoice.dateRecorded)}",
  );
  return bytes;
}

/// display the header of the recipe
/// header = {logo,companyName,CompanyAddress,CompanyContact,CompanyActivity}
List<int> _buildHeader(Generator generator, InvoiceModel invoice) {
  List<int> bytes = [];
  //logo
  if (Application.pref.getBool(StorageKeys.showLogo.name) ?? false) {
    bytes += generator.image(decodeImage(Application.pref
            .getStringList(StorageKeys.logo.name)
            ?.map((e) => int.parse(e))
            .toList() ??
        [])!);
  }
  //company name
  if (StorageKeys.showCompanyName.storedValue ?? false) {
    bytes += generator.text(
      StorageKeys.companyName.storedValue ?? "DZPos",
    );
  }
  // company number
  if (StorageKeys.showCompanyNumbers.storedValue ?? false) {
    bytes += generator.text(
      StorageKeys.companyNumbers.storedValue ?? "",
    );
  }
  // company activity
  if (StorageKeys.showCompanyActivity.storedValue ?? false) {
    bytes += generator.text(
      StorageKeys.companyActivity.storedValue ?? "",
    );
  }
  // company Address
  if (StorageKeys.showCompanyAddress.storedValue ?? false) {
    bytes += generator.text(
      StorageKeys.companyAddress.storedValue ?? "@",
    );
  }
// Account Name

  bytes += generator.text(
    "TO: ${invoice.account.name}",
    styles: PosStyles(align: PosAlign.center),
  );

  // company
  if (StorageKeys.showAccountAddress.storedValue ?? false) {
    bytes += generator.text(
      invoice.account.address ?? "@",
      styles: PosStyles(align: PosAlign.center),
    );
  }

  // Account Address
  if (StorageKeys.showAccountContact.storedValue ?? false) {
    bytes += generator.text(
      invoice.account.contact ?? "",
      styles: PosStyles(align: PosAlign.center),
    );
  }
  // TODO account total debts
  // Bottom Header
  if (StorageKeys.showBottomHeader.storedValue ?? false) {
    bytes += generator.text(StorageKeys.bottomHeader.storedValue ?? "");
  }
  return bytes;
}
