String DateToYMD(DateTime date) {
  return "${date.day}-${date.month}-${date.year}";
}

String getTime() {
  final date = DateTime.now();
  return "${date.hour}-${date.minute}";
}

String getDate() {
  final date = DateTime.now();
  return "${date.day}-${date.month}";
}
