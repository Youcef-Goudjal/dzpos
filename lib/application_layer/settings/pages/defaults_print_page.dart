import 'package:dzpos/application_layer/widgets/app_text_field.dart';
import 'package:dzpos/core/extensions/extensions.dart';
import 'package:flutter/material.dart';

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
        title: const Text("Default printing settings"),
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
                      hint: "Company Name",
                      onChanged: (input) {
                        companyName = input;
                      },
                    ),
                    AppTextField(
                      initialValue: companyNumbers,
                      hint: "Company Numbers",
                      onChanged: (input) {
                        companyNumbers = input;
                      },
                    ),
                    10.heightBox,
                    AppTextField(
                      initialValue: companyNumbers,
                      hint: "Company Numbers",
                      onChanged: (input) {
                        companyNumbers = input;
                      },
                    ),
                    10.heightBox,
                    AppTextField(
                      initialValue: companyActivity,
                      hint: "Company Activity",
                      onChanged: (input) {
                        companyActivity = input;
                      },
                    ),
                    10.heightBox,
                    AppTextField(
                      initialValue: companyAddress,
                      hint: "Company Address",
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
                        title: const Text("Print Logo"),
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
                      title: const Text("display Account Address"),
                      onChanged: (value) {
                        setState(() {
                          checkBoxValues["displayAccountAddress"] = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      value: checkBoxValues["DisplayTax"],
                      title: const Text("Display Tax information"),
                      onChanged: (value) {
                        setState(() {
                          checkBoxValues["DisplayTax"] = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      value: checkBoxValues["ShowMaterialNotes"],
                      title: const Text("Show Material Notes"),
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
                      title: const Text("display Account mobile number "),
                      onChanged: (value) {
                        setState(() {
                          checkBoxValues["displayAccountContact"] = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      value: checkBoxValues["DisplayEmployeeName"],
                      title: const Text("Display Employee Name"),
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
              "Invoice contents",
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
                  title: const Text("View balance before and after invoice"),
                  onChanged: (value) {
                    setState(() {
                      checkBoxValues["ViewBalanceBeforeAndAfter"] = value!;
                    });
                  },
                ),
                10.heightBox,
                CheckboxListTile(
                  value: checkBoxValues["DisplayPrintDateAndTime"],
                  title: const Text("Display print date and time"),
                  onChanged: (value) {
                    setState(() {
                      checkBoxValues["DisplayPrintDateAndTime"] = value!;
                    });
                  },
                ),
                10.heightBox,
                AppTextField(
                  maxLine: 3,
                  hint:
                      "Information directly below the invoice,\n such as terms and conditions etc..",
                ),
                10.heightBox,
                AppTextField(
                  maxLine: 3,
                  hint:
                      "The bottom header\n- Write here mobile number, @ etc ...",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
