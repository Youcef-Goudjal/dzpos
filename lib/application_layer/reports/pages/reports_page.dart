import 'package:dzpos/core/extensions/extensions.dart';
import 'package:dzpos/product/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({Key? key}) : super(key: key);

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
          aspectRatio: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(
              2,
              (index) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          Reports.values[index].iconPath!,
                        ),
                        5.h.heightBox,
                        Text(
                          Reports.values[index].name,
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
          Reports.values.length - 2,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                alignment: Alignment.centerLeft,
              ),
              onPressed: () {},
              icon: SvgPicture.asset(
                Reports.values[index + 2].iconPath!,
              ),
              label: Text(Reports.values[index + 2].name),
            ),
          ),
        )
      ],
    );
  }
}

enum Reports {
  profitLoss("Profit-Loss", AppAssets.comboChart),
  dailyTransaction("Daily Transaction", AppAssets.timeMachine),
  budget("Capital-Budget", AppAssets.moneyBag),
  theMostSoldMaterials("The most sold materials", AppAssets.invoice),
  theMostActiveCustomers("The most Active Customers", AppAssets.userGroups),
  showItemsThatHaveReachedAMinimum(
      "Show Items that have reached a minimum", AppAssets.trolley),
  displayItemsWhoseQuantityIsLessThan(
      "Display Items whose quantity is less than", AppAssets.unavailable),
  lessMovingMaterials("Less moving materials", AppAssets.emptyBox),
  lessMobileClients("Less mobile clients", AppAssets.cv);

  final String name;
  final String? iconPath;
  const Reports(this.name, [this.iconPath]);
}
