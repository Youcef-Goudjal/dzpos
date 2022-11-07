import 'package:intl/intl.dart';

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
