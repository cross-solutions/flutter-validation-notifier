import 'package:meta/meta.dart';
import 'package:validation_notifier/src/validation_state.dart';

/// An immutable result of a validation.
@immutable
class ValidationResult<T extends Object> {
  /// Initializes a new instance of [ValidationResult] that is invalid, with an optional [validatedValue] and
  /// an [errorMessage] describing it.
  factory ValidationResult.invalid(
          {T? validatedValue, required String errorMessage}) =>
      ValidationResult._(
          state: ValidationState.invalid,
          validatedValue: validatedValue,
          errorMessage: errorMessage);

  /// Initializes a new instance of [ValidationResult] that is valid, with an optional [validatedValue].
  factory ValidationResult.valid({T? validatedValue}) => ValidationResult._(
      state: ValidationState.valid, validatedValue: validatedValue);

  /// Initializes a new instance of [ValidationResult] that is not yet validated.
  factory ValidationResult.notValidated() =>
      const ValidationResult._(state: ValidationState.notValidated);

  const ValidationResult._(
      {required this.state, this.validatedValue, this.errorMessage});

  /// The value that has been validated.
  final T? validatedValue;

  /// The current validation state.
  final ValidationState state;

  /// The error message if [state] is invalid.
  final String? errorMessage;
}
