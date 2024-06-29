import 'package:intl/intl.dart';

String getDateCategory(DateTime date) {
  DateTime now = DateTime.now();
  DateTime tomorrow = now.add(const Duration(days: 1));
  DateTime startOfToday = DateTime(now.year, now.month, now.day);
  DateTime startOfTomorrow = DateTime(tomorrow.year, tomorrow.month, tomorrow.day);
  DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
  DateTime startOfNextWeek = startOfWeek.add(const Duration(days: 7));
  DateTime startOfMonth = DateTime(now.year, now.month, 1);
  DateTime startOfNextMonth = DateTime(now.year, now.month + 1, 1);
  DateTime startOfYear = DateTime(now.year, 1, 1);
  DateTime startOfNextYear = DateTime(now.year + 1, 1, 1);

  if (date.isAfter(startOfToday) && date.isBefore(startOfTomorrow)) {
    return 'Today';
  } else if (date.isAfter(startOfTomorrow) && date.isBefore(startOfTomorrow.add(const Duration(days: 1)))) {
    return 'Tomorrow';
  } else if (date.isAfter(startOfToday) && date.isBefore(startOfNextWeek)) {
    return 'This Week';
  } else if (date.isAfter(startOfMonth) && date.isBefore(startOfNextMonth)) {
    return 'This Month';
  } else if (date.isAfter(startOfYear) && date.isBefore(startOfNextYear)) {
    return 'This Year';
  } else {
    return DateFormat('d MMMM, yyyy').format(date);
  }
}
