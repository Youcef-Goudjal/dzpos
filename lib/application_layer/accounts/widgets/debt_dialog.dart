import 'package:drift/drift.dart' show Value;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../../core/core.dart';
import '../../application_layer.dart';

showDebtDialog(BuildContext context, {bool? isCreditor}) {
  showDialog(
    context: context,
    builder: (context) {
      return _DebtBody(
        isCreditor: isCreditor,
      );
    },
  );
}

class _DebtBody extends StatefulWidget {
  final bool? isCreditor;
  const _DebtBody({
    this.isCreditor,
    Key? key,
  }) : super(key: key);

  @override
  State<_DebtBody> createState() => _DebtBodyState();
}

class _DebtBodyState extends State<_DebtBody> {
  int? accountId;
  String desc = "";
  String amount = "";
  Account? account;
  late bool isCreditor;
  @override
  void initState() {
    super.initState();
    isCreditor = widget.isCreditor ?? true;
  }

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
                    ...await accountsRepository.allAccounts,
                  ];
                },
                autoFlipDirection: true,
                loadingBuilder: (context) {
                  return const LoadingWidget();
                },
                initialValue: account?.name ?? "",
                itemBuilder: (context, dynamic suggestion) {
                  return ListTile(
                    title: Text(suggestion.value),
                    subtitle: Text(suggestion.contact),
                  );
                },
                direction: AxisDirection.up,
                onSuggestionSelected: (suggestion) {
                  setState(() {
                    account = suggestion;
                  });
                },
              ),
              10.heightBox,
              AppTextField(
                hint: "0.00",
                keyboardType: TextInputType.number,
                label: LocaleKeys.Amount.tr(),
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
                      title: Text(LocaleKeys.Creditor.tr()),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<bool>(
                      value: false,
                      groupValue: isCreditor,
                      onChanged: (value) => setState(() {
                        isCreditor = value!;
                      }),
                      title: Text(LocaleKeys.Debtor.tr()),
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
                        child: Text(LocaleKeys.Save.tr()),
                        onPressed: () {
                          final amountD = double.tryParse(amount);
                          if (amountD != null && accountId != null) {
                            accountsRepository.registerDebt(
                              DebtsCompanion(
                                accountId: Value(accountId!),
                                amount: Value(amountD),
                                description: Value(desc),
                                isCredit: Value(isCreditor),
                                deptType: Value(DeptType.old),
                                userId: const Value(0),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    10.widthBox,
                    Expanded(
                      child: ElevatedButton(
                        child: Text(LocaleKeys.No.tr()),
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
