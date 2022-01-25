import 'package:meta/meta.dart';

/// Contains logic that validates a value [T].
@immutable
abstract class ValidationRule<T extends Object> {
  /// The error message to show when validation fails.
  String get errorMessage;

  /// Validates a [value] against a validation logic.
  ///
  /// - [value] - The value to validate.
  ///
  /// Returns a boolean whether [value] is valid or not.
  bool checkIsValid(T? value);
}
