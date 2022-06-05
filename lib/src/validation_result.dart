import 'package:meta/meta.dart';

import 'package:validation_notifier/src/validation_state.dart';

/// An immutable result of a validation.
@immutable
class ValidationResult<T extends Object> {
  /// Initializes a new instance of [ValidationResult].
  const ValidationResult({required this.state, this.validatedValue, this.errorMessage});

  /// Initializes a new instance of [ValidationResult] that is invalid, with an optional [validatedValue] and
  /// an [errorMessage] describing it.
  factory ValidationResult.invalid({T? validatedValue, required String errorMessage}) =>
      ValidationResult(state: ValidationState.invalid, validatedValue: validatedValue, errorMessage: errorMessage);

  /// Initializes a new instance of [ValidationResult] that is valid, with an optional [validatedValue].
  factory ValidationResult.valid({T? validatedValue}) =>
      ValidationResult(state: ValidationState.valid, validatedValue: validatedValue);

  /// Initializes a new instance of [ValidationResult] that is not yet validated.
  factory ValidationResult.notValidated() => const ValidationResult(state: ValidationState.notValidated);

  /// The value that has been validated.
  final T? validatedValue;

  /// The current validation state.
  final ValidationState state;

  /// The error message if [state] is invalid.
  final String? errorMessage;

  /// Checks if [validatedValue] is valid.
  bool get isValid => state == ValidationState.valid;

  /// Checks if [validatedValue] was validated.
  bool get isValidated => state != ValidationState.notValidated;

  /// Checks if [errorMessage] has value or its [state] is [ValidationState.invalid].
  bool get hasError => errorMessage?.isNotEmpty ?? state == ValidationState.invalid;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is ValidationResult<T> &&
        other.validatedValue == validatedValue &&
        other.state == state &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => validatedValue.hashCode ^ state.hashCode ^ errorMessage.hashCode;
}
