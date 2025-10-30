---
title: "Class: CompositeValidator"
description: "A validator that combines multiple validators with AND logic."
---

```dart
/// A validator that combines multiple validators with AND logic.
///
/// [CompositeValidator] runs multiple validators sequentially and only passes
/// if all validators pass. If any validator fails, validation stops and returns
/// that error. Created automatically when using the `&` operator between validators.
///
/// Example:
/// ```dart
/// CompositeValidator([
///   NonNullValidator(),
///   MinLengthValidator(3),
///   EmailValidator(),
/// ])
/// ```
class CompositeValidator<T> extends Validator<T> {
  /// The list of validators to run sequentially.
  final List<Validator<T>> validators;
  /// Creates a [CompositeValidator] from a list of validators.
  const CompositeValidator(this.validators);
  FutureOr<ValidationResult?> validate(BuildContext context, T? value, FormValidationMode state);
  Validator<T> combine(Validator<T> other);
  bool shouldRevalidate(FormKey<dynamic> source);
  bool operator ==(Object other);
  int get hashCode;
}
```
