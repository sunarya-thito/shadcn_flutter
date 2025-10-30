---
title: "Class: OrValidator"
description: "A validator that combines multiple validators with OR logic."
---

```dart
/// A validator that combines multiple validators with OR logic.
///
/// [OrValidator] passes if at least one of the wrapped validators passes.
/// Only fails if all validators fail. Useful for accepting multiple valid formats.
///
/// Example:
/// ```dart
/// OrValidator([
///   EmailValidator(),
///   PhoneValidator(),
/// ])
/// ```
class OrValidator<T> extends Validator<T> {
  /// The list of validators to combine with OR logic.
  final List<Validator<T>> validators;
  /// Creates an [OrValidator] from a list of validators.
  const OrValidator(this.validators);
  FutureOr<ValidationResult?> validate(BuildContext context, T? value, FormValidationMode state);
  Validator<T> operator |(Validator<T> other);
  bool shouldRevalidate(FormKey<dynamic> source);
  void operator ==(Object other);
  int get hashCode;
}
```
