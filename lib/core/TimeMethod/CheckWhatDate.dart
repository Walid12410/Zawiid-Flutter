import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:zawiid/localization/generated/l10n.dart';

String getDateCategory(BuildContext context, DateTime date) {
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
    return S.of(context).today;
  } else if (date.isAfter(startOfTomorrow) && date.isBefore(startOfTomorrow.add(const Duration(days: 1)))) {
    return S.of(context).tomorrow;
  } else if (date.isAfter(startOfToday) && date.isBefore(startOfNextWeek)) {
    return S.of(context).thisWeek;
  } else if (date.isAfter(startOfMonth) && date.isBefore(startOfNextMonth)) {
    return S.of(context).thisMonth;
  } else if (date.isAfter(startOfYear) && date.isBefore(startOfNextYear)) {
    return S.of(context).thisYear;
  } else {
    return DateFormat('d MMMM, yyyy').format(date);
  }
}
