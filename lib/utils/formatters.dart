import 'package:intl/intl.dart';

// format date
String formatDate(DateTime dateTime) {
  return DateFormat.yMMMMd().add_jm().format(dateTime);
}

// format amount

String formatCurrency(double value, [int precision = 0]) {
  return NumberFormat.currency(
    locale: 'en_US',
    symbol: '',
    decimalDigits: precision,
  ).format(value);
}
