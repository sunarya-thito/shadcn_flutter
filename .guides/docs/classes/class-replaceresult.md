---
title: "Class: ReplaceResult"
description: "A validation result that indicates a value should be replaced."
---

```dart
/// A validation result that indicates a value should be replaced.
///
/// [ReplaceResult] is used when validation determines that the submitted
/// value should be transformed or replaced with a different value. For example,
/// trimming whitespace or formatting input.
class ReplaceResult<T> extends ValidationResult {
  /// The replacement value to use.
  final T value;
  /// Creates a [ReplaceResult] with the specified replacement value.
  const ReplaceResult(this.value, {required super.state});
  /// Creates a [ReplaceResult] already attached to a form field key.
  const ReplaceResult.attached(this.value, {required FormKey key, required super.state});
  FormKey get key;
  ReplaceResult<T> attach(FormKey key);
}
```
