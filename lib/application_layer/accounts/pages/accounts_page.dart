import 'package:dzpos/core/extensions/extensions.dart';
import 'package:dzpos/product/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountsPage extends StatelessWidget {
  const AccountsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 15.h,
      ),
      children: [
        AspectRatio(
          aspectRatio: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(
              3,
              (index) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          Accounts.values[index].iconPath!,
                        ),
                        5.h.heightBox,
                        Text(
                          Accounts.values[index].name,
                          maxLines: 2,
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        20.h.heightBox,
        ...List.generate(
          Accounts.values.length - 3,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                alignment: Alignment.centerLeft,
              ),
              onPressed: () {},
              icon: SvgPicture.asset(
                Accounts.values[index + 3].iconPath!,
              ),
              label: Text(Accounts.values[index + 3].name),
            ),
          ),
        )
      ],
    );
  }
}

enum Accounts {
  payment("Payment to Account", AppAssets.cashInHand),
  catchFromAccount("Catch From Account", AppAssets.receiveCash),
  registerNewDebt("Register New debt", AppAssets.newSvg),
  debtList("Debt List", AppAssets.check),
  accountStatement("Account Statement", AppAssets.profiles),
  boxMovement("Box Movement", AppAssets.masterCard),
  fundAndRepair("Fund And Repair", AppAssets.maintenance),
  expenseRecording("Expense Recording", AppAssets.moneyBag),
  externalRevenueRecording("External Revenue Recording", AppAssets.wallet),
  oldDebts("Old Debts", AppAssets.coins),
  accountsList("Accounts List", AppAssets.userGroups),
  openingAccount("Opening Account", AppAssets.customer);

  final String name;
  // final VoidCallback? onPressed;
  final String? iconPath;

  const Accounts(this.name, [this.iconPath]);
}
