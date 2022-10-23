import 'package:dzpos/application_layer/settings/pages/labels_page.dart';
import 'package:dzpos/core/services/database.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils.dart';
import 'package:image/image.dart';

import '../../../product/product.dart';
import '../../utils/utils.dart';

Future<List<int>> buildThermal(
    CapabilityProfile profile, PaperSize paper, FullInvoice invoice) async {
  final generator = Generator(paper, profile);
  generator.setStyles(
    const PosStyles.defaults(
      codeTable: "CP1256",
      align: PosAlign.center,
    ),
  );
  List<int> bytes = [];
  bytes.addAll(_buildHeader(generator));
  bytes.addAll(generator.hr());
  bytes.addAll(_contentHeader(generator, invoice));
  bytes.addAll(generator.hr());
  bytes.addAll(_contentTable(generator, invoice));

  return bytes;
}

Iterable<int> _contentTable(Generator generator, FullInvoice invoice) {
  List<int> bytes = [];
  return bytes;
}

/// displays the header of the content
/// content {invoiceId,date and time}
Iterable<int> _contentHeader(Generator generator, FullInvoice invoice) {
  List<int> bytes = [];
  bytes += generator.text(
    "${PrinterLabels.invoiceId.value}# : ${invoice.invoiceId}",
  );
  bytes += generator.text(
    "${PrinterLabels.date.value}# : ${dateToYMD(invoice.dateRecorded)}",
  );
  bytes += generator.text(
    "${PrinterLabels.date.value}# : ${getTime(invoice.dateRecorded)}",
  );
  return bytes;
}

/// display the header of the recipe
/// header = {logo,companyName,CompanyAddress,CompanyContact,CompanyActivity}
List<int> _buildHeader(Generator generator) {
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
  if (Application.pref.getBool(StorageKeys.showCompanyName.name) ?? false) {
    bytes += generator.text(
      Application.pref.getString(StorageKeys.companyName.name) ?? "DZPos",
    );
  }
  // company activity
  if (Application.pref.getBool(StorageKeys.showCompanyActivity.name) ?? false) {
    bytes += generator.text(
      Application.pref.getString(StorageKeys.companyActivity.name) ?? "",
    );
  }
  // company number
  if (Application.pref.getBool(StorageKeys.showCompanyNumbers.name) ?? false) {
    bytes += generator.text(
      Application.pref.getString(StorageKeys.companyNumbers.name) ?? "",
    );
  }
  // company
  if (Application.pref.getBool(StorageKeys.showAccountAddress.name) ?? false) {
    bytes += generator.text(
      Application.pref.getString(StorageKeys.companyAddress.name) ?? "",
    );
  }
  return bytes;
}
