import 'package:dzpos/core/extensions/extensions.dart';
import 'package:dzpos/product/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

enum DebtType {
  none,
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
  DebtType debtTypeSelected = DebtType.none;
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
                CheckboxListTile(
                  value: checkList["customers"],
                  onChanged: (value) {
                    setState(() {
                      checkList["customers"] = value!;
                    });
                  },
                  title: const Text("Customers"),
                ),
                CheckboxListTile(
                  value: checkList["suppliers"],
                  onChanged: (value) {
                    setState(() {
                      checkList["suppliers"] = value!;
                    });
                  },
                  title: const Text("Suppliers"),
                ),
                CheckboxListTile(
                  value: checkList["other"],
                  onChanged: (value) {
                    setState(() {
                      checkList["other"] = value!;
                    });
                  },
                  title: const Text("Other"),
                ),
              ],
            ),
            10.heightBox,
            // ChipsChoice.single(
            //   value: DebtType.none,
            //   onChanged: (value) => setState(() {
            //     debtTypeSelected = value as DebtType? ?? DebtType.none;
            //   }),
            //   choiceItems: C2Choice.listFrom<List<DebtType>, DebtType>(
            //     source: DebtType.values,
            //     value: (index, item) => DebtType.values,
            //     label: (index, item) => item.name,
            //   ),
            // ),
            // 10.heightBox,
            Expanded(
              child: ListView(),
            ),
            const SizedBox(
              height: 40,
              child: _ActionsDebt(),
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
