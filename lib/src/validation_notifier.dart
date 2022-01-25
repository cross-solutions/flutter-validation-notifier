import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:validation_notifier/src/validation_result.dart';
import 'package:validation_notifier/src/validation_rule.dart';

/// A [ValueNotifier] that validates a value [T] against a specified collection of [ValidationRule].
class ValidationNotifier<T extends Object> extends ValueNotifier<ValidationResult<T>> {
  final StreamController<T?> _valueToValidateCtrl = StreamController.broadcast();
  T? _valueToValidate;

  /// Creates a new instance of [ValidationNotifier].
  ///
  /// - [initialValue] - The initial value of [ValidationNotifier.valueToValidate].
  /// - [rules] - A collection of [ValidationRule] which will validate [ValidationNotifier.valueToValidate].
  ValidationNotifier({required List<ValidationRule<T>> rules, T? initialValue})
      : assert(rules.isNotEmpty),
        super(ValidationResult.notValidated()) {
    valueToValidate = initialValue;
    this.rules = List.unmodifiable(rules);
    valueToValidateChanged = _valueToValidateCtrl.stream;
  }

  /// Stream of events when [valueToValidate] is updated.
  late final Stream<T?> valueToValidateChanged;

  /// The collection of [ValidationRule] used to validate [ValidationNotifier.valueToValidate].
  ///
  /// This is a read-only, unmodifiable collection.
  late final List<ValidationRule<T>> rules;

  /// The value which will be validated by each [ValidationNotifier.rules].
  T? get valueToValidate => _valueToValidate;
  set valueToValidate(T? newValue) {
    _valueToValidate = newValue;
    _valueToValidateCtrl.add(_valueToValidate);
  }

  /// Convenience method to update [valueToValidate].
  ///
  /// - [newValueToValidate] - The new value of [valueToValidate].
  // ignore: use_setters_to_change_properties
  void update(T? newValueToValidate) => valueToValidate = newValueToValidate;

  /// Validates [ValidationNotifier.valueToValidate].
  ///
  /// This will call [ValidationRule.checkIsValid] for each [rules]. If the rule becomes invalid
  ///
  /// Returns the [ValidationResult] of the validation. Updates [ValueNotifier.value] with the same result.
  ValidationResult<T> validate() {
    value = ValidationResult.notValidated();

    for (final rule in rules) {
      final isValid = rule.checkIsValid(valueToValidate);

      if (!isValid) {
        return value = ValidationResult.invalid(validatedValue: valueToValidate, errorMessage: rule.errorMessage);
      }
    }

    return value = ValidationResult.valid(validatedValue: valueToValidate);
  }

  @override
  void dispose() {
    _valueToValidateCtrl.close();
    super.dispose();
  }
}
