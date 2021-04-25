### ValidationNotifier

A [`ValueNotifier`](https://api.flutter.dev/flutter/foundation/ValueNotifier-class.html) that validates a value against a collection of customizable rules.

#### Create a rule

You can create your own set of rules by inheriting `ValidationRule<T>`

Let's say we create a rule that validates inputs that are required callled `RequiredRule`

```dart
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
```

Another rule that validates string inputs requiring them to have a email format called `EmailFormatRule`

```dart
class EmailFormatRule extends ValidationRule<String> {
  EmailFormatRule({String errorMessage = 'Invalid email format'}) : super(errorMessage);

 static final emailRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  @override
  void validate(String? value) {
    if (value == null) {
      isValid = false;
    } else {
      isValid = emailRegex.hasMatch(value);
    }
  }
}
```

#### Add the rules

You can add your previously created rules to a `ValidationNotifier<T>`

```dart
final email = ValidationNotifier<String>(rules: [
  RequiredRule(),
  EmailFormatRule(),
]);
```

Use `email` in a [`ValueListenableBuilder`](https://api.flutter.dev/flutter/widgets/ValueListenableBuilder-class.html)

```dart
ValueListenableBuilder<ValidationResult<String>>(
  valueListenable: email,
  builder: (context, value, child) {
    return TextFormField(
      onChanged: (v) => email.valueToValidate = v,
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      decoration: InputDecoration(
        labelText: 'Email',
        errorText: value.errorMessage,
      ),
    );
  },
)
```

Call `ValidationNotifier<T>.validate()` to validate `valueToValidate` using the rules you defined. 

```dart
// A callback of a button for logging-in

void onLogin() {
  final validationResult = email.validate();

  if (evalidationResult == ValidationState.valid) {
    // Valid
  } else {
    // Invalid
  }
}
```

<img src="https://raw.githubusercontent.com/cross-solutions/flutter-validation-notifier/main/example.gif"/>

#### Important Notes

- When overriding `ValidationRule.validate()`, you must set the value of [isValid] here. 
- When a rule is invalid, `ValidationNotifier<T>.value` will be set and other calls to remaining rules will be canceled.

- The sequence of the rules to be called during validation is determined by the sequence of the rules in `ValidationNotifier<T>` constructor.