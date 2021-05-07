import 'package:example/regular_expressions.dart';
import 'package:validation_notifier/validation_notifier.dart';

class RequiredStringRule extends ValidationRule<String> {
  RequiredStringRule({String errorMessage = 'This field is required'}) : super(errorMessage);

  @override
  bool checkIsValid(String? value) => value?.isNotEmpty ?? false;
}

class EmailFormatRule extends ValidationRule<String> {
  EmailFormatRule({String errorMessage = 'Invalid email format'}) : super(errorMessage);

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
  StringLengthRule({String errorMessage = 'Invalid length', required this.length}) : super(errorMessage);

  final int length;

  @override
  bool checkIsValid(String? value) {
    final strValue = value ?? '';
    return strValue.length >= length;
  }
}
