class StringConstants {
  static const String title = "Dzpos";
}

enum StorageKeys {
  language,
  themeMode,
  theme,
  thermalPrinterProfile,
  thermalPaperSize,
  pdfPageFormat,
  showLogo,
  logo,
  printLabels,
  showCompanyName,
  companyName,
  showCompanyActivity,
  companyActivity,
  showCompanyNumbers,
  companyNumbers,
  showCompanyAddress,
  companyAddress,
  showAccountAddress,
  showAccountContact,
  showTax,
  showMaterialNotes,
  showEmployeeName,
  showBalanceBeforeAndAfter,
  showPrintDateAndTime,
  ;

  String get name {
    return toString().split(".").last;
  }
}
