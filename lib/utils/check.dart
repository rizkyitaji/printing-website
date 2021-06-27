part of 'utils.dart';

class Check {
  static bool isAlphanumeric(String string) {
    if (string.contains(RegExp(r'[0-9]'))) {
      return true;
    } else {
      return false;
    }
  }
}
