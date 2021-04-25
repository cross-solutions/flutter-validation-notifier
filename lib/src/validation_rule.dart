import 'package:meta/meta.dart';

/// Contains logic that validates a value [T].
abstract class ValidationRule<T extends Object> {
  bool _isValid = true;

  /// Initializes a new instance of [ValidationRule].
  ///
  /// - [errorMessage] - The error message to show when validation fails.
  ValidationRule(this.errorMessage);

  /// The error message to show when validation fails.
  @protected
  String errorMessage;

  /// Whether the validation is valid or not.
  bool get isValid => _isValid;

  @protected
  set isValid(bool newValue) => _isValid = newValue;

  /// The validation message to show after calling [ValidationRule.validate].
  ///
  /// If [ValidationRule.isValid] is `false`, returns [ValidationRule.errorMessage], otherwise returns an empty string.
  String get validationMessage => isValid ? '' : errorMessage;

  /// Validates the [value].
  ///
  /// When overriding, you must set the value of [isValid] here.
  void validate(T? value);
}
