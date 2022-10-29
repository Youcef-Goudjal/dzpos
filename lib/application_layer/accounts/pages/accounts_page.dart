import 'package:dzpos/application_layer/auth/utils.dart';
import 'package:dzpos/core/enums.dart';
import 'package:dzpos/core/extensions/extensions.dart';
import 'package:dzpos/product/product.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/manager/language/locale_keys.g.dart';
import '../../../core/manager/route/routes.dart';
import '../../application_layer.dart';

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
                    onPressed: () => AccountsPages.values[index].onPressed(context),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AccountsPages.values[index].iconPath!,
                        ),
                        5.h.heightBox,
                        Text(
                          AccountsPages.values[index].name,
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
          AccountsPages.values.length - 3,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  alignment: Alignment.centerLeft,
                ),
                onPressed: () => AccountsPages.values[index + 3].onPressed(context),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AccountsPages.values[index + 3].iconPath!,
                    ),
                    5.widthBox,
                    Expanded(child: Text(AccountsPages.values[index + 3].name)),
                  ],
                )),
          ),
        )
      ],
    );
  }
}

enum AccountsPages {
  payment("Payment to Account", AppAssets.cashInHand), //
  catchFromAccount("Catch From Account", AppAssets.receiveCash), //
  registerNewDebt("Register New debt", AppAssets.newSvg), //
  debtList("Debt List", AppAssets.check), //
  accountStatement("Account Statement", AppAssets.profiles), //
  boxMovement("Box Movement", AppAssets.masterCard),
  fundAndRepair("Fund And Repair", AppAssets.maintenance),
  expenseRecording("Expense Recording", AppAssets.moneyBag),
  externalRevenueRecording("External Revenue Recording", AppAssets.wallet),
  oldDebts("Old Debts", AppAssets.coins), //
  accountsList("Accounts List", AppAssets.userGroups), //
  openingAccount("Opening Account", AppAssets.customer); //

  String get name {
    switch (this) {
      case AccountsPages.payment:
        return LocaleKeys.accounts_Payment_to_Account.tr();
      case AccountsPages.catchFromAccount:
        return LocaleKeys.accounts_Catch_From_Account.tr();
      case AccountsPages.registerNewDebt:
        return LocaleKeys.accounts_Register_New_debt.tr();
      case AccountsPages.debtList:
        return LocaleKeys.accounts_Debt_List.tr();
      case AccountsPages.accountStatement:
        return LocaleKeys.accounts_Account_Statement.tr();
      case AccountsPages.boxMovement:
        return LocaleKeys.accounts_Box_Movement.tr();
      case AccountsPages.fundAndRepair:
        return LocaleKeys.accounts_Fund_And_Repair.tr();
      case AccountsPages.expenseRecording:
        return LocaleKeys.accounts_Expense_Recording.tr();
      case AccountsPages.externalRevenueRecording:
        return LocaleKeys.accounts_External_Revenue_Recording.tr();
      case AccountsPages.oldDebts:
        return LocaleKeys.accounts_Old_Debts.tr();
      case AccountsPages.accountsList:
        return LocaleKeys.accounts_Accounts_List.tr();
      case AccountsPages.openingAccount:
        return LocaleKeys.accounts_Opening_Account.tr();
    }
  }

  final String n;
  final String? iconPath;

  const AccountsPages(this.n, [this.iconPath]);

  void onPressed(BuildContext context) {
    switch (this) {
      case AccountsPages.openingAccount:
        context.pushNamed(AppRoutes.newAccount.name);
        break;

      case AccountsPages.accountsList:
        context.pushNamed(AppRoutes.accountsList.name);
        break;
      case AccountsPages.oldDebts:
        showDebtDialog(context);
        break;
      case AccountsPages.debtList:
        context.pushNamed(AppRoutes.debtList.name);
        break;
      case AccountsPages.payment:
        context.pushNamed(AppRoutes.debt.name, extra: DebtType.debtor);
        break;
      case AccountsPages.catchFromAccount:
        context.pushNamed(AppRoutes.debt.name, extra: DebtType.creditor);
        break;
      case AccountsPages.registerNewDebt:
        context.pushNamed(AppRoutes.debt.name, extra: DebtType.all);
        break;

      default:
        statusHandler(context, Status.failure, msg: "Coming soon!!");
    }
    return;
  }
}
