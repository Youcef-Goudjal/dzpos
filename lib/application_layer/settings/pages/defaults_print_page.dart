import '../../widgets/app_text_field.dart';
import '../../../core/extensions/extensions.dart';
import '../../../product/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/manager/language/locale_keys.g.dart';

class DefaultPrintPage extends StatefulWidget {
  const DefaultPrintPage({super.key});

  @override
  State<DefaultPrintPage> createState() => _DefaultPrintPageState();
}

class _DefaultPrintPageState extends State<DefaultPrintPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.Default_printing_settings.tr()),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        physics: const BouncingScrollPhysics(),
        children: [
          Row(
            children: [
              SizedBox(
                height: 150,
                width: 150,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Icon(Icons.image),
                ),
              ),
              10.widthBox,
              Expanded(
                child: CheckboxListTile(
                  value: StorageKeys.showLogo.storedValue ?? false,
                  title: Text(LocaleKeys.Print_Logo.tr()),
                  onChanged: (value) {
                    StorageKeys.showLogo.setValue(value ?? false);
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          10.heightBox,
          // Company name
          AppTextField(
            prefix: Checkbox(
              value: StorageKeys.showCompanyName.storedValue ?? false,
              onChanged: (value) {
                StorageKeys.showCompanyName.setValue(value ?? false);
                setState(() {});
              },
            ),
            initialValue: StorageKeys.companyName.storedValue,
            hint: LocaleKeys.Company_Name.tr(),
            onChanged: (input) {
              StorageKeys.companyName.setValue(input);
              setState(() {});
            },
          ),
          10.heightBox,
          // company contact
          AppTextField(
            prefix: Checkbox(
              value: StorageKeys.showCompanyNumbers.storedValue ?? false,
              onChanged: (value) {
                StorageKeys.showCompanyNumbers.setValue(value ?? false);
                setState(() {});
              },
            ),
            initialValue: StorageKeys.companyNumbers.storedValue,
            hint: LocaleKeys.Company_Numbers.tr(),
            onChanged: (input) {
              StorageKeys.companyNumbers.setValue(input);
            },
          ),
          10.heightBox,
          // Company Address
          AppTextField(
            prefix: Checkbox(
              value: StorageKeys.showCompanyAddress.storedValue ?? false,
              onChanged: (value) {
                StorageKeys.showCompanyAddress.setValue(value ?? false);
                setState(() {});
              },
            ),
            initialValue: StorageKeys.companyAddress.storedValue,
            hint: LocaleKeys.Company_Address.tr(),
            onChanged: (input) {
              StorageKeys.companyAddress.setValue(input);
              setState(() {});
            },
          ),
          10.heightBox,
          // company activity
          AppTextField(
            prefix: Checkbox(
              value: StorageKeys.showCompanyActivity.storedValue ?? false,
              onChanged: (value) {
                StorageKeys.showCompanyActivity.setValue(value ?? false);
                setState(() {});
              },
            ),
            initialValue: StorageKeys.companyActivity.storedValue,
            hint: LocaleKeys.Company_Activity.tr(),
            onChanged: (input) {
              StorageKeys.companyActivity.setValue(input);
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    CheckboxListTile(
                      value:
                          StorageKeys.showAccountAddress.storedValue ?? false,
                      title: Text(LocaleKeys.display_Account_Address.tr()),
                      onChanged: (value) {
                        StorageKeys.showAccountAddress.setValue(value);
                      },
                    ),
                    CheckboxListTile(
                      value: StorageKeys.showTax.storedValue ?? false,
                      title: Text(LocaleKeys.Display_Tax_information.tr()),
                      onChanged: (value) {
                        StorageKeys.showTax.setValue(value);
                      },
                    ),
                    CheckboxListTile(
                      value: StorageKeys.showMaterialNotes.storedValue ?? false,
                      title: Text(LocaleKeys.Show_Material_Notes.tr()),
                      onChanged: (value) {
                        StorageKeys.showMaterialNotes.setValue(value);
                      },
                    ),
                  ],
                ),
              ),
              10.widthBox,
              Expanded(
                child: Column(
                  children: [
                    CheckboxListTile(
                      value:
                          StorageKeys.showAccountContact.storedValue ?? false,
                      title:
                          Text(LocaleKeys.display_Account_mobile_number.tr()),
                      onChanged: (value) {
                        StorageKeys.showAccountContact.setValue(value);
                      },
                    ),
                    CheckboxListTile(
                      value: StorageKeys.showEmployeeName.storedValue ?? false,
                      title: Text(LocaleKeys.Display_Employee_Name.tr()),
                      onChanged: (value) {
                        StorageKeys.showEmployeeName.setValue(value);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            height: 40,
            color: context.colorScheme.primaryContainer,
            child: Text(
              LocaleKeys.Invoice_contents.tr(),
              style: context.textTheme.titleMedium!.copyWith(
                color: context.colorScheme.onPrimaryContainer,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                CheckboxListTile(
                  value: StorageKeys.showBalanceBeforeAndAfter.storedValue ??
                      false,
                  title: Text(
                      LocaleKeys.View_balance_before_and_after_invoice.tr()),
                  onChanged: (value) {
                    StorageKeys.showBalanceBeforeAndAfter.setValue(value);
                  },
                ),
                10.heightBox,
                CheckboxListTile(
                  value: StorageKeys.showPrintDateAndTime.storedValue ?? false,
                  title: Text(LocaleKeys.Display_print_date_and_time.tr()),
                  onChanged: (value) {
                    StorageKeys.showPrintDateAndTime.setValue(value);
                  },
                ),
                10.heightBox,
                CheckboxListTile(
                  value: StorageKeys.showBottomHeader.storedValue ?? false,
                  onChanged: (value) =>
                      StorageKeys.showBottomHeader.setValue(value),
                  title: AppTextField(
                    initialValue: StorageKeys.bottomHeader.storedValue,
                    maxLine: 3,
                    hint: LocaleKeys.bottom_header.tr(),
                    onChanged: (input) {
                      StorageKeys.bottomHeader.setValue(input);
                    },
                  ),
                ),
                10.heightBox,
                CheckboxListTile(
                  value: StorageKeys.showBottomInvoice.storedValue ?? false,
                  onChanged: (value) =>
                      StorageKeys.showBottomInvoice.setValue(value),
                  title: AppTextField(
                    maxLine: 3,
                    initialValue: StorageKeys.bottomInvoice.storedValue,
                    hint: LocaleKeys.bottom_invoice.tr(),
                    onChanged: (input) {
                      StorageKeys.bottomInvoice.setValue(input);
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
