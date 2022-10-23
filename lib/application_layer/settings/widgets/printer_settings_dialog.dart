import 'package:dzpos/core/extensions/extensions.dart';
import 'package:dzpos/product/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/manager/language/locale_keys.g.dart';
import '../../application_layer.dart';

Future showPrinterSettings(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return const _SettingDialog();
    },
  );
}

class _SettingDialog extends StatefulWidget {
  const _SettingDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<_SettingDialog> createState() => _SettingDialogState();
}

class _SettingDialogState extends State<_SettingDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(LocaleKeys.printPaperType.tr()),
            10.heightBox,
            Row(
              children: [
                Expanded(
                  child: RadioListTile<PaperType>(
                    value: PaperType.p58,
                    groupValue: PaperType.fromString(
                        StorageKeys.paperType.storedValue ?? ""),
                    onChanged: (value) {
                      setState(() {
                        StorageKeys.paperType.setValue(PaperType.p58.name);
                      });
                    },
                  ),
                ),
                5.widthBox,
                Expanded(
                  child: RadioListTile<PaperType>(
                    value: PaperType.p80,
                    groupValue: PaperType.fromString(
                        StorageKeys.paperType.storedValue ?? ""),
                    onChanged: (value) {
                      setState(() {
                        StorageKeys.paperType.setValue(PaperType.p80.name);
                      });
                    },
                  ),
                ),
              ],
            ),
            10.heightBox,
            Row(
              children: [
                Expanded(
                  child: Text(LocaleKeys.settings_Font_Size.tr()),
                ),
                Expanded(
                  flex: 2,
                  child: AppTextField(
                    initialValue: "${StorageKeys.fontSize.storedValue}",
                    textInputAction: TextInputAction.next,
                    onChanged: (input) {
                      setState(() {
                        StorageKeys.fontSize
                            .setValue(double.tryParse(input) ?? 10);
                      });
                    },
                  ),
                )
              ],
            ),
            10.heightBox,
            Row(
              children: [
                Expanded(
                  child: Text(LocaleKeys.printCut.tr()),
                ),
                Expanded(
                  flex: 2,
                  child: AppTextField(
                    initialValue: "${StorageKeys.spacingCut.storedValue}",
                    textInputAction: TextInputAction.next,
                    onChanged: (input) {
                      setState(() {
                        StorageKeys.spacingCut
                            .setValue(int.tryParse(input) ?? 7);
                      });
                    },
                  ),
                )
              ],
            ),
            10.heightBox,
            Row(
              children: [
                Checkbox(
                  value: StorageKeys.printDuplicate.storedValue ?? false,
                  onChanged: (value) {
                    setState(() {
                      StorageKeys.printDuplicate.setValue(value ?? false);
                    });
                  },
                ),
                10.widthBox,
                Expanded(child: Text(LocaleKeys.printDuplicate.tr()))
              ],
            ),
            10.heightBox,
            Text(LocaleKeys.printFontType.tr()),
            RadioListTile<bool>(
              value: true,
              title: Text(LocaleKeys.printFontType1.tr()),
              groupValue: StorageKeys.fontSize.storedValue ?? false,
              onChanged: (value) {
                setState(() {
                  StorageKeys.fontType.setValue(true);
                });
              },
            ),
            5.heightBox,
            RadioListTile<bool>(
              value: false,
              title: Text(LocaleKeys.printFontType2.tr()),
              groupValue: StorageKeys.fontSize.storedValue ?? false,
              onChanged: (value) {
                setState(() {
                  StorageKeys.fontType.setValue(false);
                });
              },
            ),
            15.heightBox,
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Center(
                child: Text(LocaleKeys.printSaveSettings.tr()),
              ),
            )
          ],
        ),
      ),
    );
  }
}

enum PaperType {
  A4,
  p58,
  p80,
  custom;

  /// width of the page in mm (-1 => not set)
  double get width {
    switch (this) {
      case PaperType.p58:
        return 58;
      case PaperType.p80:
        return 80;
      default:
        return -1;
    }
  }

  String get name {
    return toString().split(".").last;
  }

  static PaperType fromString(String value) {
    switch (value) {
      case "A4":
        return PaperType.A4;
      case "p58":
        return PaperType.p58;
      case "p80":
        return PaperType.p80;
      default:
        return PaperType.custom;
    }
  }
}
