import 'package:dzpos/application_layer/accounts/accounts.dart';
import 'package:dzpos/core/extensions/extensions.dart';
import 'package:dzpos/core/utils/date_utils.dart';
import 'package:dzpos/product/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/manager/language/locale_keys.g.dart';

enum DebtType {
  all,
  debtor,
  creditor;

  String get name {
    switch (this) {
      case DebtType.debtor:
        return LocaleKeys.Debtor.tr();
      case DebtType.creditor:
        return LocaleKeys.We_pay.tr();
      default:
        return LocaleKeys.All_debts.tr();
    }
  }

  bool get isPaying => this == DebtType.creditor;
}

class DebtListPage extends StatefulWidget {
  const DebtListPage({super.key});

  @override
  State<DebtListPage> createState() => _DebtListPageState();
}

class _DebtListPageState extends State<DebtListPage> {
  DebtType debtTypeSelected = DebtType.all;
  Map<String, bool> checkList = {
    LocaleKeys.customers.tr(): false,
    LocaleKeys.suppliers.tr(): true,
    LocaleKeys.others.tr(): true,
  };

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeptListCubit(accountsRepository),
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: Text(LocaleKeys.accounts_Debt_List.tr()),
                actions: [
                  IconButton(
                    onPressed: () {
                      //TODO: print debts
                    },
                    icon: const Icon(Icons.print),
                  ),
                  10.widthBox,
                  IconButton(
                    onPressed: () {
                      // filter result
                    },
                    icon: const Icon(Icons.filter_alt),
                  ),
                ],
              ),
            ];
          },
          body: Column(
            children: [
              Text(LocaleKeys.Debt_Show.tr()),
              Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      value: checkList[LocaleKeys.customers.tr()],
                      onChanged: (value) {
                        setState(() {
                          checkList[LocaleKeys.customers.tr()] = value!;
                        });
                      },
                      title: Text(
                        LocaleKeys.customers.tr(),
                        style: const TextStyle(
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      value: checkList[LocaleKeys.suppliers.tr()],
                      onChanged: (value) {
                        setState(() {
                          checkList[LocaleKeys.suppliers.tr()] = value!;
                        });
                      },
                      title: Text(
                        LocaleKeys.suppliers.tr(),
                        style: const TextStyle(
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      value: checkList[LocaleKeys.others.tr()],
                      onChanged: (value) {
                        setState(() {
                          checkList[LocaleKeys.others.tr()] = value!;
                        });
                      },
                      title: Text(
                        LocaleKeys.others.tr(),
                        style: const TextStyle(
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    // color: context.primaryColor.withOpacity(0.5),
                    border: Border.all(
                      color: context.primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              debtTypeSelected = DebtType.creditor;
                            });
                          },
                          child: Ink(
                            decoration: BoxDecoration(
                              color: debtTypeSelected == DebtType.creditor
                                  ? context.primaryColor
                                  : null,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                DebtType.creditor.name,
                                style: TextStyle(
                                  color: context.onSecondaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      VerticalDivider(
                        color: context.primaryColor,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              debtTypeSelected = DebtType.debtor;
                            });
                          },
                          child: Ink(
                            decoration: BoxDecoration(
                              color: debtTypeSelected == DebtType.debtor
                                  ? context.primaryColor
                                  : null,
                            ),
                            child: Center(
                              child: Text(
                                DebtType.debtor.name,
                                style: TextStyle(
                                  color: context.onSecondaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      VerticalDivider(
                        color: context.primaryColor,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              debtTypeSelected = DebtType.all;
                            });
                          },
                          child: Ink(
                            decoration: BoxDecoration(
                              color: debtTypeSelected == DebtType.all
                                  ? context.primaryColor
                                  : null,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                DebtType.all.name,
                                style: TextStyle(
                                  color: context.onSecondaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              10.heightBox,
              Expanded(
                child: BlocBuilder<DeptListCubit, DeptListState>(
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
                            "${debt.debt.amount}",
                            style: context.textTheme.titleLarge,
                          ),
                          subtitle: Text(
                              "${DateToYMD(debt.debt.dateRecorded)}  ${debt.account?.name}"),
                          leading: debt.debt.isCredit
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
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 50,
                  child: _ActionsDebt(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionsDebt extends StatelessWidget {
  const _ActionsDebt({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              showDebtDialog(context);
            },
            icon: const Icon(Icons.note_add_rounded),
            label: Center(child: Text(LocaleKeys.New_debt.tr())),
          ),
        ),
        10.w.widthBox,
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              showDebtDialog(context, isCreditor: true);
            },
            icon: SvgPicture.asset(AppAssets.cashInHand),
            label: Center(
              child: Text(
                LocaleKeys.Pay_for_an_account.tr(),
                style: const TextStyle(overflow: TextOverflow.ellipsis),
              ),
            ),
          ),
        ),
        10.w.widthBox,
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              showDebtDialog(context, isCreditor: false);
            },
            icon: SvgPicture.asset(AppAssets.receiveCash),
            label: Center(
              child: Text(
                LocaleKeys.Receive_from_an_account.tr(),
                style: const TextStyle(overflow: TextOverflow.ellipsis),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
