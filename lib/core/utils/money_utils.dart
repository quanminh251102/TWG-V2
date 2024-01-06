import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class VietnameseMoneyFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    String cleanValue = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    int parsedValue = int.tryParse(cleanValue) ?? 0;

    final formatter = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    String formattedValue = formatter.format(parsedValue);

    int selectionIndex = 0;
    if (oldValue.text.length < newValue.text.length) {
      selectionIndex = newValue.selection.start -
          (oldValue.text.length - formattedValue.length);
      selectionIndex = selectionIndex.clamp(0, formattedValue.length) - 1;
    } else if (parsedValue == 0) {
      selectionIndex = 1;
    } else {
      selectionIndex = newValue.selection.start;
      int diff = oldValue.text.length - newValue.text.length - 1;
      selectionIndex = (selectionIndex - diff).clamp(0, formattedValue.length);
    }

    return TextEditingValue(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: selectionIndex),
      composing: TextRange.empty,
    );
  }

  String convertToNormalString(String formattedMoney) {
    String cleanValue = formattedMoney.replaceAll(RegExp(r'[^0-9]'), '');
    int parsedValue = int.tryParse(cleanValue) ?? 0;
    return parsedValue.toString();
  }

  String formatToVietnameseCurrency(String numberString) {
    // Chuyển đổi chuỗi thành số nguyên.
    int number = int.tryParse(numberString) ?? 0;

    // Sử dụng NumberFormat từ package intl để format số.
    final formatter = NumberFormat('#,##0', 'vi_VN');

    // Trả về chuỗi đã được format kèm theo đơn vị VND.
    return '${formatter.format(number)} ₫';
  }
}
