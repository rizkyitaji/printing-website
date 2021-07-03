part of 'utils.dart';

class Check {
  static bool isNumeric(String string) {
    return string.contains(RegExp(r'[a-zA-Z.]'));
  }
}
