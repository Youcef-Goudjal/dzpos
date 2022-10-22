import 'package:dzpos/application_layer/accounts/accounts.dart';
import 'package:dzpos/application_layer/widgets/widgets.dart';
import 'package:dzpos/core/extensions/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../../core/manager/language/locale_keys.g.dart';
import '../../../core/services/database.dart';

class AccountCard extends StatelessWidget {
  final String? initialValue;
  final void Function(Account account) onSelected;
  final void Function(String input)? onChangedAmount, onChangeNote;
  final void Function(bool?)? onTypeChanged;
  final bool isCreditor;
  final void Function()? onSave;

  const AccountCard({
    super.key,
    this.onSave,
    this.onTypeChanged,
    this.initialValue = "",
    this.isCreditor = true,
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
            color: context.colorScheme.primaryContainer,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TypeAheadFormField<Account>(
                initialValue: initialValue,
                onSuggestionSelected: onSelected,
                itemBuilder: (context, dynamic itemData) {
                  return ListTile(
                    title: Text(itemData.value),
                    subtitle: Text(
                      LocaleKeys.Phone.tr(args: [itemData.contact]),
                    ),
                  );
                },
                suggestionsCallback: (pattern) async {
                  final accounts = await accountsRepository.allAccounts;
                  return accounts;
                },
              ),
              Text("Date : ${now.day}-${now.month}-${now.year}"),
              10.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: RadioListTile<bool>(
                      value: true,
                      groupValue: isCreditor,
                      onChanged: onTypeChanged,
                      title: Text(LocaleKeys.Creditor.tr()),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<bool>(
                      value: false,
                      groupValue: isCreditor,
                      onChanged: onTypeChanged,
                      title: Text(LocaleKeys.Debtor.tr()),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                          child: AppTextField(
                            hint: LocaleKeys.Amount.tr(),
                            onChanged: onChangedAmount,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        10.heightBox,
                        SizedBox(
                          height: 40,
                          child: AppTextField(
                            hint: LocaleKeys.Notes.tr(),
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
                          children: [
                            const Icon(Icons.save),
                            Text(LocaleKeys.Save.tr()),
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
      ),
    );
  }
}
