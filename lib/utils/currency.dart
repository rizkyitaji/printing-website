part of 'utils.dart';

class Currency {
  static String format(dynamic number) {
    return NumberFormat.currency(
      locale: 'id-ID',
      symbol: 'IDR ',
      decimalDigits: 0,
    ).format(number);
  }
}
