import 'package:meta/meta.dart';

/// Contains logic that validates a value [T].
abstract class ValidationRule<T extends Object> {
  bool _isValid = false;

  /// The error message to show when validation fails.
  String get errorMessage;

  /// Whether the validation is valid or not.
  bool get isValid => _isValid;

  /// Validates the [value] by calling [ValidationRule.checkIsValid].
  ///
  /// - [value] - The value to validate.
  @mustCallSuper
  void validate(T? value) {
    _isValid = checkIsValid(value);
  }

  /// Contains the validation logic.
  ///
  /// - [value] - The value to validate.
  @protected
  bool checkIsValid(T? value);
}
