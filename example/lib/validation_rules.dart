import 'package:example/regular_expressions.dart';
import 'package:validation_notifier/validation_notifier.dart';

class RequiredRule<T extends Object> extends ValidationRule<T> {
  RequiredRule({String errorMessage = 'This field is required'}) : super(errorMessage);

  @override
  void validate(T? value) {
    isValid = value != null;

    if (value is String?) {
      final strValue = value as String?;
      isValid = strValue?.isNotEmpty ?? false;
    }
  }
}

class EmailFormatRule extends ValidationRule<String> {
  EmailFormatRule({String errorMessage = 'Invalid email format'}) : super(errorMessage);

  @override
  void validate(String? value) {
    if (value == null) {
      isValid = false;
    } else {
      isValid = RegularExpressions.emailRegex.hasMatch(value);
    }
  }
}

class StringLengthRule extends ValidationRule<String> {
  StringLengthRule({String errorMessage = 'Invalid length', required this.length}) : super(errorMessage);

  final int length;

  @override
  void validate(String? value) {
    final strValue = value ?? '';
    isValid = strValue.length >= length;
  }
}
