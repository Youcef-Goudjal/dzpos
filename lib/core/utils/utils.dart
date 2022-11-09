import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../core.dart';

String dateToYMD(DateTime date) {
  return "${date.day}-${date.month}-${date.year}";
}

String getTime([DateTime? date]) {
  date = date ?? DateTime.now();
  return "${date.hour}-${date.minute}";
}

String getDate() {
  final date = DateTime.now();
  return "${date.day}-${date.month}";
}

String formatCurrency(double amount) {
  return '${amount.toStringAsFixed(2)}';
}

String formatDate(DateTime date) {
  final format = DateFormat.yMMMd('en_US');
  return format.format(date);
}

void statusHandler(BuildContext context, Status status, {String? msg}) {
  if (status.isSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          "$msg",
        ),
      ),
    );
  } else if (status.isFailure) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: context.theme.errorColor,
        content: Text(
          "Oops !! \n $msg",
        ),
      ),
    );
  } else if (status == Status.info) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: context.colorScheme.secondaryContainer,
        duration: const Duration(milliseconds: 100),
        // margin: const EdgeInsets.all(16),
        content: Text(
          "$msg",
        ),
      ),
    );
  }
}
