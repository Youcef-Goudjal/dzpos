import 'package:dzpos/application_layer/accounts/cubit/account_statement_cubit.dart';
import 'package:dzpos/application_layer/auth/utils.dart';
import 'package:dzpos/application_layer/widgets/app_text_field.dart';
import 'package:dzpos/core/extensions/extensions.dart';
import 'package:dzpos/core/services/database.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../../core/manager/language/locale_keys.g.dart';
import '../../../core/utils/utils.dart';
import '../../../data/data.dart';
import '../../../domain/domain.dart';

final AccountsRepository accountsRepository = AccountsRepositoryImpl();

class AccountStatementPage extends StatelessWidget {
  const AccountStatementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _AccountStatementBody();
  }
}

class _AccountStatementBody extends StatefulWidget {
  const _AccountStatementBody({
    Key? key,
  }) : super(key: key);

  @override
  State<_AccountStatementBody> createState() => _AccountStatementBodyState();
}

class _AccountStatementBodyState extends State<_AccountStatementBody> {
  Account? account;
  DateTimeRange? dateRange;

  @override
  void initState() async {
    super.initState();
    final result = await showDialog(
      context: context,
      builder: (context) {
        return const _AccountStatementDialog();
      },
    );
    account = result[0];
    dateRange = result[1];
  }

  @override
  Widget build(BuildContext context) {
    if (account == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return BlocProvider(
      create: (context) => AccountStatementCubit(accountsRepository, account!),
      child: BlocListener<AccountStatementCubit, AccountStatementState>(
        listener: (context, state) {
          statusHandler(context, state.status, msg: state.msg);
        },
        child: Builder(builder: (context) {
          final accountStatementCubit = context.read<AccountStatementCubit>();
          return Scaffold(
            appBar: AppBar(
              title: Text(accountStatementCubit.state.account.name),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: InkWell(
                  onTap: () async {
                    final date = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(3000),
                    );
                    accountStatementCubit.onDateChanged(date);
                  },
                  child: Text(
                    LocaleKeys.From.tr(
                            args: [accountStatementCubit.state.from]) +
                        LocaleKeys.To.tr(
                            args: [accountStatementCubit.state.to]),
                  ),
                ),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child:
                      BlocBuilder<AccountStatementCubit, AccountStatementState>(
                    builder: (context, state) {
                      if (state.status.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ListView.separated(
                        itemCount: state.debts.length,
                        separatorBuilder: (context, index) => 15.h.heightBox,
                        itemBuilder: (context, index) {
                          final debt = state.debts[index];
                          return ListTile(
                            title: Text(
                              "${debt.amount}",
                              style: context.textTheme.titleLarge,
                            ),
                            subtitle: Text(
                                "${dateToYMD(debt.dateRecorded)}  ${state.account.name}"),
                            leading: debt.isCredit
                                ? const Icon(
                                    Icons.arrow_circle_up_outlined,
                                    color: Colors.green,
                                  )
                                : const Icon(
                                    Icons.arrow_circle_down_outlined,
                                    color: Colors.red,
                                  ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: context.secondaryColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  height: 30,
                  child: Row(
                    children: [
                      const Icon(Icons.print),
                      Text(LocaleKeys.Print_detailed_Report.tr())
                    ],
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}

/// this dialog shown when the page started
class _AccountStatementDialog extends StatefulWidget {
  const _AccountStatementDialog();

  @override
  State<_AccountStatementDialog> createState() =>
      __AccountStatementDialogState();
}

class __AccountStatementDialogState extends State<_AccountStatementDialog> {
  String? name = "";
  DateTimeRange? dateRange;
  Account? account;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: context.primaryColor),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            TypeAheadFormField<Account>(
              initialValue: name,
              suggestionsCallback: (pattern) async {
                final accounts = await accountsRepository.allAccounts;

                return [
                  ...accounts,
                ];
              },
              itemBuilder: (context, dynamic suggestion) {
                return ListTile(
                  title: Text(suggestion.value),
                  subtitle: Text(suggestion.contact),
                );
              },
              onSuggestionSelected: (Account suggestion) {
                setState(() {
                  name = suggestion.name;
                });
                account = suggestion;
              },
            ),
            10.heightBox,
            Row(
              children: [
                Text(LocaleKeys.From.tr()),
                InkWell(
                  onTap: () async {
                    await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );
                  },
                  child: AppTextField(
                    initialValue:
                        "${dateRange?.start.day}-${dateRange?.start.month}-${dateRange?.start.year}",
                    enabled: false,
                  ),
                ),
                Text(LocaleKeys.To.tr()),
                InkWell(
                  onTap: () async {
                    dateRange = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );
                    setState(() {});
                  },
                  child: AppTextField(
                    initialValue:
                        "${dateRange?.end.day}-${dateRange?.end.month}-${dateRange?.end.year}",
                    enabled: false,
                  ),
                ),
              ],
            ),
            20.heightBox,
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (account != null && dateRange != null) {
                    Navigator.pop(context, [account, dateRange]);
                  }
                },
                child: Center(
                  child: Text(LocaleKeys.Show_Result.tr()),
                ),
              ),
            ),
            10.heightBox,
          ],
        ),
      ),
    );
  }
}
