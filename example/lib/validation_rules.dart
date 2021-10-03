import 'package:example/regular_expressions.dart';
import 'package:validation_notifier/validation_notifier.dart';

class RequiredStringRule extends ValidationRule<String> {
  @override
  bool checkIsValid(String? value) => value?.isNotEmpty ?? false;

  @override
  String get errorMessage => 'This field is required';
}

class EmailFormatRule extends ValidationRule<String> {
  @override
  String get errorMessage => 'Invalid email format';

  @override
  bool checkIsValid(String? value) {
    if (value == null) {
      return false;
    } else {
      return RegularExpressions.emailRegex.hasMatch(value);
    }
  }
}

class StringLengthRule extends ValidationRule<String> {
  StringLengthRule(this.length);

  final int length;

  @override
  String get errorMessage => 'Invalid length';

  @override
  bool checkIsValid(String? value) {
    final strValue = value ?? '';
    return strValue.length >= length;
  }
}
