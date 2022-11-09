import '../../../core/extensions/extensions.dart';
import '../../../product/product.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/manager/language/locale_keys.g.dart';

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
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                alignment: Alignment.centerLeft,
              ),
              onPressed: () {},
              child: Row(
                children: [
                  SvgPicture.asset(
                    Reports.values[index + 2].iconPath!,
                  ),
                  5.widthBox,
                  Text(Reports.values[index + 2].name),
                ],
              ),
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

  final String n;
  String get name {
    switch (this) {
      case Reports.profitLoss:
        return LocaleKeys.reports_ProfitLoss.tr();
      case Reports.dailyTransaction:
        return LocaleKeys.reports_Daily_Transaction.tr();
      case Reports.budget:
        return LocaleKeys.reports_CapitalBudget.tr();
      case Reports.theMostActiveCustomers:
        return LocaleKeys.reports_The_most_Active_Customers.tr();
      case Reports.theMostSoldMaterials:
        return LocaleKeys.reports_The_most_sold_materials.tr();
      case Reports.displayItemsWhoseQuantityIsLessThan:
        return LocaleKeys.reports_Display_Items_whose_quantity_is_less_than
            .tr();
      case Reports.lessMobileClients:
        return LocaleKeys.reports_Less_mobile_clients.tr();
      case Reports.lessMovingMaterials:
        return LocaleKeys.reports_Less_moving_materials.tr();
      case Reports.showItemsThatHaveReachedAMinimum:
        return LocaleKeys.reports_Show_Items_that_have_reached_a_minimum.tr();
    }
  }

  final String? iconPath;
  const Reports(this.n, [this.iconPath]);
}
