import 'package:intl/intl.dart';

class CurrencyUtils {
  static double currencyRound(double value) {
    return (value * 100).round() / 100.0;
  }

  static String GetCurrencyString(String currencyCode, double value) {
    return (value < 0 ? '-' : '') +
        currencyCode +
        value.abs().toStringAsFixed(2);
  }

  static String formatCurrency(double amount) {
    return format.format(amount) + 'đ';
  }

  static final format = NumberFormat('#,###');
}
