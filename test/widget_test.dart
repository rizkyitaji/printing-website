import 'package:flutter_test/flutter_test.dart';
import 'package:printing/utils/utils.dart';

void main() {
  test('description', () {
    var s = '12000';
    expect(Check.isNumeric(s), true);
  });
}
