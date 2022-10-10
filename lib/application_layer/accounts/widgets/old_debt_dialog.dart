import 'package:dzpos/application_layer/application_layer.dart';
import 'package:dzpos/core/extensions/extensions.dart';
import 'package:dzpos/data/data.dart';
import 'package:dzpos/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

final AccountsRepository repository = AccountsRepositoryImpl();

showOldDebtDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: context.theme.backgroundColor,
        child: const _OldDebtBody(),
      );
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
  bool isCreditor = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TypeAheadField(
          textFieldConfiguration: const TextFieldConfiguration(
            autofocus: true,
          ),
          suggestionsCallback: (pattern) async {
            final customers = await repository.allCustomers;
            final suppliers = await repository.allSuppliers;
            return [
              ...customers,
              ...suppliers,
            ];
          },
          itemBuilder: (context, dynamic suggestion) {
            return ListTile(
              title: Text(suggestion.name),
              subtitle: Text(suggestion.contact),
            );
          },
          onSuggestionSelected: (suggestion) {
            //TODO:
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
            RadioListTile<bool>(
              value: true,
              groupValue: isCreditor,
              onChanged: (value) => setState(() {
                isCreditor = value!;
              }),
              title: const Text("Creditor"),
            ),
            RadioListTile<bool>(
              value: false,
              groupValue: isCreditor,
              onChanged: (value) => setState(() {
                isCreditor = value!;
              }),
              title: const Text("Debtor"),
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
    );
  }
}
