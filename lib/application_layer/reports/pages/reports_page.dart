import 'package:flutter/material.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
    );
  }
}

enum Reports {
  profitLoss("Profit-Loss"),
  dailyTransaction("Daily Transaction"),
  budget("Capital-Budget"),
  theMostSoldMaterials("The most sold materials"),
  theMostActiveCustomers("The most Active Customers"),
  showItemsThatHaveReachedAMinimum("Show Items that have reached a minimum"),
  displayItemsWhoseQuantityIsLessThan(
      "Display Items whose quantity is less than"),
  lessMovingMaterials("Less moving materials"),
  lessMobileClients("Less mobile clients");

  final String name;
  const Reports(this.name);
}
