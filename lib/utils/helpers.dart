import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final dateFormat = DateFormat('dd/MM/yyyy');
final timeFormat = DateFormat('H:m');
final numberFormat = NumberFormat('#,###');

extension ExtendedIterable<E> on Iterable<E> {
  /// Like Iterable<T>.map but the callback has index as second argument
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }

  void forEachIndexed(void Function(E e, int i) f) {
    var i = 0;
    forEach((e) => f(e, i++));
  }
}

extension DateTimeExtension on DateTime {
  TimeOfDay? toTimeSpan() {
    if (hour == 0 && minute == 0) {
      return null;
    }

    return TimeOfDay(hour: hour, minute: minute);
  }

  DateTime toSpecificDateTime(TimeOfDay time) {
    return DateTime(year, month, day, time.hour, time.minute);
  }
}
