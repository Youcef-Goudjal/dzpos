import 'package:dzpos/application_layer/accounts/accounts.dart';
import 'package:dzpos/application_layer/widgets/widgets.dart';
import 'package:dzpos/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AccountCard extends StatelessWidget {
  final void Function(dynamic account) onSelected;
  final void Function(String input)? onChangedAmount, onChangeNote;
  final void Function()? onSave;
  const AccountCard({
    super.key,
    this.onSave,
    required this.onSelected,
    this.onChangedAmount,
    this.onChangeNote,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: context.primaryColor,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          TypeAheadFormField(
            textFieldConfiguration: const TextFieldConfiguration(
              textInputAction: TextInputAction.next,
            ),
            onSuggestionSelected: onSelected,
            itemBuilder: (context, dynamic itemData) {
              return ListTile(
                title: Text(itemData.name),
                subtitle: Text("phone : ${itemData.contact}"),
              );
            },
            suggestionsCallback: (pattern) async {
              final customers = await repository.allCustomers;
              final suppliers = await repository.allSuppliers;
              return [
                ...customers,
                ...suppliers,
              ];
            },
          ),
          Text("Date : ${now.day}-${now.month}-${now.year}"),
          10.heightBox,
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    AppTextField(
                      hint: "Amount",
                      onChanged: onChangedAmount,
                    ),
                    10.heightBox,
                    AppTextField(
                      hint: "Notes",
                      maxLine: 2,
                      onChanged: onChangeNote,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: onSave,
                  child: Center(
                    child: Column(
                      children: const [
                        Icon(Icons.save),
                        Text("Save"),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
