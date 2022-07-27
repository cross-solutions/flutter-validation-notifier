## [1.0.0] - April 25, 2021

- Initial release 🎉

## [1.0.0+1] - April 25, 2021

- Updated readme

## [1.1.0] - May 7, 2021

- Add `ValidationRule.checkIsValid`.

## [1.2.0] - May 19, 2021

- Updated to support Flutter 2.2.0

## [1.3.0] - October 1, 2021

- Updated to support Flutter 2.5.0

## [1.3.1] - October 1, 2021

- Removed calling `notifyListeners` when updating `ValueNotifier.valueToValidate`

## [1.3.2] - October 3, 2021

- Made `ValidationRule` constructor parameter `errorMessage` optional

## [1.4.0] - October 3, 2021

- Made `ValidationRule.errorMessage` abstract

## [1.4.1] - December 8, 2021

- Add convenience method and properties

## [1.4.2] - December 8, 2021

- Add equality operator for `ValidationResult<T>`

## [1.4.3] - January 24, 2022

- Add `valueToValidateChanged` stream

## [1.4.3+1] - January 24, 2022

- Finalize `valueToValidateChanged` stream

## [1.4.4] - January 25, 2022

- Make `ValidationRule` immutable
- Removed `ValidationRule.isValid` and `ValidationRule.validate`
- Finalized `ValidationNotifier.rules`

## [1.4.5] - June 5, 2022

- Add `ValidationResult.hasError`

## [1.4.6] - July 27, 2022

- Add constant constructor to `ValidationRule<T>`