import 'package:intl/intl.dart';

class PriceFormat {
  final NumberFormat _formatter;

  PriceFormat({
    String currencyName = 'EUR',
    String symbol = '€',
    int decimalDigits = 2,
  }) : _formatter = NumberFormat.currency(
            name: currencyName, symbol: symbol, decimalDigits: decimalDigits);

  String format(num price) {
    return _formatter.format(price);
  }
}
