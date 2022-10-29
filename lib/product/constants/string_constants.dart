import '../application.dart';

class StringConstants {
  static const String title = "Dzpos";
}

enum StorageKeys {
  dbPath,
  language,
  themeMode,
  theme,
  pricingPolicy(StoredType.int),
  pricingMethod(StoredType.int),
  paperType(),
  fontSize(StoredType.double),
  spacingCut(StoredType.int),
  printDuplicate(StoredType.bool),
  fontType(StoredType.bool),
  thermalPrinterProfile,
  thermalPaperSize,
  pdfPageFormat,
  showLogo(StoredType.bool),
  logo(StoredType.list),
  printerMac,
  printerName,
  printLabels(StoredType.list),
  showCompanyName(StoredType.bool),
  companyName,
  showCompanyActivity(StoredType.bool),
  companyActivity,
  showCompanyNumbers(StoredType.bool),
  companyNumbers,
  showCompanyAddress(StoredType.bool),
  companyAddress,
  bottomHeader,
  bottomInvoice,
  showAccountAddress(StoredType.bool),
  showAccountContact(StoredType.bool),
  showTax(StoredType.bool),
  showMaterialNotes(StoredType.bool),
  showEmployeeName(StoredType.bool),
  showBalanceBeforeAndAfter(StoredType.bool),
  showPrintDateAndTime(StoredType.bool),
  settingsAlwaysBackup(StoredType.bool),
  settingsAddQuantity(StoredType.bool),
  settingsUseBox(StoredType.bool),
  settingsSellLestThanCost(StoredType.bool),
  settingsActivateNotificationOfQuantity(StoredType.bool),
  settingsAllowSellWhenQuantityIsZero(StoredType.bool),
  settingsSeparateBetweenCustomersAndSuppliers(StoredType.bool),
  settingsOpenSellInvoicesOnStart(StoredType.bool),
  settingsDefaultIsGeneralCustomer(StoredType.bool),
  settingsShowFrozenProducts(StoredType.bool),
  settingsShowFrozenAccounts(StoredType.bool),
  settingsUpdateAllUnitsInInvoice(StoredType.bool),
  ;

  final StoredType type;
  const StorageKeys([this.type = StoredType.string]);
  String get name {
    return toString().split(".").last;
  }

  dynamic get storedValue {
    final pref = Application.pref;
    switch (type) {
      case StoredType.list:
        return pref.getStringList(name);
      case StoredType.bool:
        return pref.getBool(name);
      case StoredType.string:
        return pref.getString(name);
      case StoredType.double:
        return pref.getDouble(name);
      case StoredType.int:
        return pref.getInt(name);
    }
  }

  Future<bool> setValue(dynamic value) async {
    try {
      final pref = Application.pref;
      switch (type) {
        case StoredType.list:
          return pref.setStringList(name, value);
        case StoredType.bool:
          return pref.setBool(name, value);
        case StoredType.string:
          return pref.setString(name, value);
        case StoredType.double:
          return pref.setDouble(name, value);
        case StoredType.int:
          return pref.setInt(name, value);
      }
    } on Exception {
      return false;
    }
  }
}

enum StoredType { bool, string, double, int, list }
