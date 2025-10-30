---
title: "Class: InvalidResult"
description: "A validation result indicating that validation failed."
---

```dart
/// A validation result indicating that validation failed.
///
/// [InvalidResult] contains an error message describing why validation failed.
/// This is the most common validation result type returned by validators when
/// a value doesn't meet the validation criteria.
class InvalidResult extends ValidationResult {
  /// The error message describing the validation failure.
  final String message;
  /// Creates an [InvalidResult] with the specified error message.
  const InvalidResult(this.message, {required super.state});
  /// Creates an [InvalidResult] already attached to a form field key.
  const InvalidResult.attached(this.message, {required FormKey key, required super.state});
  FormKey get key;
  InvalidResult attach(FormKey key);
}
```
