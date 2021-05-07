import 'package:meta/meta.dart';

/// Contains logic that validates a value [T].
abstract class ValidationRule<T extends Object> {
  bool _isValid = false;

  /// Initializes a new instance of [ValidationRule].
  ///
  /// - [errorMessage] - The error message to show when validation fails.
  ValidationRule(this.errorMessage);

  /// The error message to show when validation fails.
  @protected
  String errorMessage;

  /// Whether the validation is valid or not.
  bool get isValid => _isValid;

  /// The validation message to show after calling [ValidationRule.validate].
  ///
  /// If [ValidationRule.isValid] is `false`, returns [ValidationRule.errorMessage], otherwise returns an empty string.
  String get validationMessage => _isValid ? '' : errorMessage;

  /// Validates the [value] by calling [ValidationRule.checkIsValid].
  ///
  /// - [value] - The value to validate.
  @nonVirtual
  void validate(T? value) {
    _isValid = checkIsValid(value);
  }

  /// Contains the validation logic.
  ///
  /// - [value] - The value to validate.
  @protected
  bool checkIsValid(T? value);
}
