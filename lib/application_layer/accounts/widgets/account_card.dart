import 'package:dzpos/application_layer/accounts/accounts.dart';
import 'package:dzpos/application_layer/widgets/widgets.dart';
import 'package:dzpos/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../../core/services/database.dart';

class AccountCard extends StatelessWidget {
  final void Function(Account account) onSelected;
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: context.primaryColor,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TypeAheadFormField<Account>(
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
                final accounts = await repository.allAccounts;
                
                return [
                  ...accounts,
                 
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
                      SizedBox(
                        height: 50,
                        child: AppTextField(
                          hint: "Amount",
                          onChanged: onChangedAmount,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      10.heightBox,
                      SizedBox(
                        height: 40,
                        child: AppTextField(
                          hint: "Notes",
                          // maxLine: 2,
                          onChanged: onChangeNote,
                        ),
                      ),
                    ],
                  ),
                ),
                5.widthBox,
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
      ),
    );
  }
}
