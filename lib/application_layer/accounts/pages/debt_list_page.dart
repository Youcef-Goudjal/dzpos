import 'package:dzpos/core/extensions/extensions.dart';
import 'package:dzpos/product/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

enum DebtType {
  all,
  debtor,
  creditor;

  String get name {
    switch (this) {
      case DebtType.debtor:
        return "Debtor";
      case DebtType.creditor:
        return "We pay";
      default:
        return "All debts";
    }
  }
}

class DebtListPage extends StatefulWidget {
  const DebtListPage({super.key});

  @override
  State<DebtListPage> createState() => _DebtListPageState();
}

class _DebtListPageState extends State<DebtListPage> {
  DebtType debtTypeSelected = DebtType.all;
  Map<String, bool> checkList = {
    "customers": false,
    "suppliers": true,
    "other": true,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: const Text("Debt List"),
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
            const Text("Debt Show"),
            Row(
              children: [
                Expanded(
                  child: CheckboxListTile(
                    value: checkList["customers"],
                    onChanged: (value) {
                      setState(() {
                        checkList["customers"] = value!;
                      });
                    },
                    title: const Text(
                      "Customers",
                      style: TextStyle(
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: CheckboxListTile(
                    value: checkList["suppliers"],
                    onChanged: (value) {
                      setState(() {
                        checkList["suppliers"] = value!;
                      });
                    },
                    title: const Text(
                      "Suppliers",
                      style: TextStyle(
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: CheckboxListTile(
                    value: checkList["other"],
                    onChanged: (value) {
                      setState(() {
                        checkList["other"] = value!;
                      });
                    },
                    title: const Text(
                      "Other",
                      style: TextStyle(
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
              child: ListView(),
            ),
            const SizedBox(
              height: 40,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: _ActionsDebt(),
              ),
            )
          ],
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
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.note_add_rounded),
              label: const Text("New debt"),
            ),
          ),
          10.w.widthBox,
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: SvgPicture.asset(AppAssets.cashInHand),
              label: const Text(
                "Pay for an account",
                style: TextStyle(overflow: TextOverflow.ellipsis),
              ),
            ),
          ),
          10.w.widthBox,
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: SvgPicture.asset(AppAssets.receiveCash),
              label: const Text(
                "Receive from an account",
                style: TextStyle(overflow: TextOverflow.ellipsis),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
