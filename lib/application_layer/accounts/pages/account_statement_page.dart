import 'package:dzpos/application_layer/accounts/cubit/account_statement_cubit.dart';
import 'package:dzpos/application_layer/widgets/app_text_field.dart';
import 'package:dzpos/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../../data/data.dart';
import '../../../domain/domain.dart';

final AccountsRepository repository = AccountsRepositoryImpl();

class AccountStatementPage extends StatelessWidget {
  const AccountStatementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountStatementCubit(),
      child: const _AccountStatementBody(),
    );
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
  @override
  void initState() async {
    super.initState();
    await showDialog(
      context: context,
      builder: (context) {
        return const _AccountStatementDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final accountStatementCubit = context.read<AccountStatementCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(accountStatementCubit.state.account.name),
        bottom: const _BottomAppBar(),
      ),
      body: Column(
        children: [
          Expanded(
            // Todo: List of this account debt
            child: ListView(),
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
              children: const [
                Icon(Icons.print),
                Text("Print detailed Report")
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _BottomAppBar extends StatelessWidget with PreferredSizeWidget {
  const _BottomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final accountStatementCubit = context.read<AccountStatementCubit>();

    return Text(
        "From :${accountStatementCubit.state.from}  To:${accountStatementCubit.state.to}");
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
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
  dynamic result;
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
            TypeAheadFormField(
              initialValue: name,
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
              onSuggestionSelected: (dynamic suggestion) {
                setState(() {
                  name = suggestion.name;
                });
                result = suggestion;
              },
            ),
            10.heightBox,
            Row(
              children: [
                const Text("From :"),
                InkWell(
                  onTap: () async {
                    await showDateRangePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now(),
                    );
                  },
                  child: AppTextField(
                    initialValue:
                        "${dateRange?.start.day}-${dateRange?.start.month}-${dateRange?.start.year}",
                    enabled: false,
                  ),
                ),
                const Text("To :"),
                InkWell(
                  onTap: () async {
                    dateRange = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime.now(),
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
                  if (result != null && dateRange != null) {
                    context
                        .read<AccountStatementCubit>()
                        .saveDialogData(result, dateRange!);
                    Navigator.pop(context);
                  }
                },
                child: const Center(
                  child: Text("Show Result"),
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
