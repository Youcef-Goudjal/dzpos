import 'package:dzpos/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountsPage extends StatelessWidget {
  const AccountsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 3,
          child: Row(
            children: List.generate(
              3,
              (index) => ElevatedButton(
                onPressed: () {},
                child: Text(Accounts.values[index].name),
              ),
            ),
          ),
        ),
        ListView.separated(
          itemCount: Accounts.values.length - 3,
          itemBuilder: (context, index) {
            return TextButton(
              onPressed: () {},
              child: Text(Accounts.values[index + 3].name),
            );
          },
          separatorBuilder: (context, index) {
            return 20.h.heightBox;
          },
        ),
      ],
    );
  }
}

enum Accounts {
  payment(
    "Payment to Account",
  ),
  catchFromAccount("Catch From Account"),
  registerNewDebt("Register New debt"),
  debtList("Debt List"),
  accountStatement("Account Statement"),
  boxMovement("Box Movement"),
  fundAndRepair("Fund And Repair"),
  expenseRecording("Expense Recording"),
  externalRevenueRecording("External Revenue Recording"),
  oldDebts("Old Debts"),
  accountsList("Accounts List"),
  openingAccount("Opening Account");

  final String name;
  // final VoidCallback? onPressed;
  // final Widget? icon;

  const Accounts(this.name);
}
