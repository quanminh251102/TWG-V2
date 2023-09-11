import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String toDateString({String type = "HH:mm dd/MM/yyyy"}) {
    return DateFormat(type).format(this);
  }

  String toTimeString({String type = "HH:mm"}) {
    return DateUtils.isSameDay(this, DateTime.now())
        ? ('Hôm nay ${DateFormat(type).format(this)}')
        : DateFormat("HH:mm dd/MM/yyyy").format(this);
  }

  String toDayString({String type = "HH:mm"}) {
    return DateUtils.isSameDay(this, DateTime.now())
        ? 'Hôm nay'
        : DateUtils.isSameDay(
                this, DateTime.now().subtract(const Duration(days: 1)))
            ? 'Hôm qua'
            : DateFormat("dd/MM/yyyy").format(this);
  }
}
