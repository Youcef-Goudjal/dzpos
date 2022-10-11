import 'package:dzpos/application_layer/application_layer.dart';
import 'package:dzpos/core/extensions/extensions.dart';
import 'package:dzpos/core/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

showOldDebtDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return const _OldDebtBody();
    },
  );
}

class _OldDebtBody extends StatefulWidget {
  const _OldDebtBody({
    Key? key,
  }) : super(key: key);

  @override
  State<_OldDebtBody> createState() => _OldDebtBodyState();
}

class _OldDebtBodyState extends State<_OldDebtBody> {
  late int accountId;
  String? desc;
  String? amount;
  Account? account;
  bool isCreditor = true;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor:
          isCreditor ? context.theme.backgroundColor : context.secondaryColor,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TypeAheadFormField<Account>(
                suggestionsCallback: (pattern) async {
                  return [
                    ...await repository.allAccounts,
                  ];
                },
                autoFlipDirection: true,
                loadingBuilder: (context) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                initialValue: account?.name ?? "",
                itemBuilder: (context, dynamic suggestion) {
                  return ListTile(
                    title: Text(suggestion.name),
                    subtitle: Text(suggestion.contact),
                  );
                },
                hideKeyboardOnDrag: true,
                direction: AxisDirection.up,
                hideOnEmpty: true,
                onSuggestionSelected: (suggestion) {
                  setState(() {
                    account = suggestion;
                  });
                },
              ),
              10.heightBox,
              AppTextField(
                initialValue: "0.00",
                keyboardType: TextInputType.number,
                hint: "Amount",
              ),
              10.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: RadioListTile<bool>(
                      value: true,
                      groupValue: isCreditor,
                      onChanged: (value) => setState(() {
                        isCreditor = value!;
                      }),
                      title: const Text("Creditor"),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<bool>(
                      value: false,
                      groupValue: isCreditor,
                      onChanged: (value) => setState(() {
                        isCreditor = value!;
                      }),
                      title: const Text("Debtor"),
                    ),
                  ),
                ],
              ),
              10.heightBox,
              AppTextField(
                hint: "Explanation of constraint",
                maxLine: 2,
                onChanged: (input) => desc = input,
              ),
              10.heightBox,
              SizedBox(
                height: 60,
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        child: const Text("Save"),
                        onPressed: () {},
                      ),
                    ),
                    10.widthBox,
                    Expanded(
                      child: ElevatedButton(
                        child: const Text("Cancel"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
