import 'package:dzpos/application_layer/widgets/app_text_field.dart';
import 'package:dzpos/core/extensions/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/manager/language/locale_keys.g.dart';

class DefaultPrintPage extends StatefulWidget {
  const DefaultPrintPage({super.key});

  @override
  State<DefaultPrintPage> createState() => _DefaultPrintPageState();
}

class _DefaultPrintPageState extends State<DefaultPrintPage> {
  Map<String, bool> checkBoxValues = {
    "printLogo": false,
    "displayAccountAddress": false,
    "displayAccountContact": true,
    "DisplayTax": false,
    "ShowMaterialNotes": false,
    "DisplayEmployeeName": true,
    "ViewBalanceBeforeAndAfter": true,
    "DisplayPrintDateAndTime": true,
  };
  String companyName = "";
  String companyNumbers = "";
  String companyActivity = "";
  String companyAddress = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.Default_printing_settings.tr()),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                    child: Column(
                  children: [
                    AppTextField(
                      initialValue: companyName,
                      hint: LocaleKeys.Company_Name.tr(),
                      onChanged: (input) {
                        companyName = input;
                      },
                    ),
                    AppTextField(
                      initialValue: companyNumbers,
                      hint: LocaleKeys.Company_Numbers.tr(),
                      onChanged: (input) {
                        companyNumbers = input;
                      },
                    ),
                    10.heightBox,
                    AppTextField(
                      initialValue: companyNumbers,
                      hint: LocaleKeys.Company_Numbers.tr(),
                      onChanged: (input) {
                        companyNumbers = input;
                      },
                    ),
                    10.heightBox,
                    AppTextField(
                      initialValue: companyActivity,
                      hint: LocaleKeys.Company_Activity.tr(),
                      onChanged: (input) {
                        companyActivity = input;
                      },
                    ),
                    10.heightBox,
                    AppTextField(
                      initialValue: companyAddress,
                      hint: LocaleKeys.Company_Address.tr(),
                      onChanged: (input) {
                        companyAddress = input;
                      },
                    ),
                    10.heightBox,
                  ],
                )),
                10.widthBox,
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Center(
                            child: Icon(Icons.image),
                          ),
                        ),
                      ),
                      10.heightBox,
                      CheckboxListTile(
                        value: checkBoxValues["printLogo"],
                        title: Text(LocaleKeys.Print_Logo.tr()),
                        onChanged: (value) {
                          setState(() {
                            checkBoxValues["printLogo"] = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    CheckboxListTile(
                      value: checkBoxValues["displayAccountAddress"],
                      title: Text(LocaleKeys.display_Account_Address.tr()),
                      onChanged: (value) {
                        setState(() {
                          checkBoxValues["displayAccountAddress"] = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      value: checkBoxValues["DisplayTax"],
                      title: Text(LocaleKeys.Display_Tax_information.tr()),
                      onChanged: (value) {
                        setState(() {
                          checkBoxValues["DisplayTax"] = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      value: checkBoxValues["ShowMaterialNotes"],
                      title: Text(LocaleKeys.Show_Material_Notes.tr()),
                      onChanged: (value) {
                        setState(() {
                          checkBoxValues["ShowMaterialNotes"] = value!;
                        });
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
                      value: checkBoxValues["displayAccountContact"],
                      title:
                          Text(LocaleKeys.display_Account_mobile_number.tr()),
                      onChanged: (value) {
                        setState(() {
                          checkBoxValues["displayAccountContact"] = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      value: checkBoxValues["DisplayEmployeeName"],
                      title: Text(LocaleKeys.Display_Employee_Name.tr()),
                      onChanged: (value) {
                        setState(() {
                          checkBoxValues["DisplayEmployeeName"] = value!;
                        });
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
                  value: checkBoxValues["ViewBalanceBeforeAndAfter"],
                  title: Text(
                      LocaleKeys.View_balance_before_and_after_invoice.tr()),
                  onChanged: (value) {
                    setState(() {
                      checkBoxValues["ViewBalanceBeforeAndAfter"] = value!;
                    });
                  },
                ),
                10.heightBox,
                CheckboxListTile(
                  value: checkBoxValues["DisplayPrintDateAndTime"],
                  title: Text(LocaleKeys.Display_print_date_and_time.tr()),
                  onChanged: (value) {
                    setState(() {
                      checkBoxValues["DisplayPrintDateAndTime"] = value!;
                    });
                  },
                ),
                10.heightBox,
                AppTextField(
                  maxLine: 3,
                  hint: LocaleKeys.bottom_header.tr(),
                ),
                10.heightBox,
                AppTextField(
                  maxLine: 3,
                  hint: LocaleKeys.bottom_invoice.tr(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
