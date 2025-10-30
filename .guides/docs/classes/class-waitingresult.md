---
title: "Class: WaitingResult"
description: "Validation result indicating a validation is in progress."
---

```dart
/// Validation result indicating a validation is in progress.
///
/// Used when asynchronous validation is being performed and the result
/// is not yet available.
class WaitingResult extends ValidationResult {
  /// Creates a waiting result attached to a form key.
  const WaitingResult.attached({required FormKey key, required super.state});
  FormKey get key;
  WaitingResult attach(FormKey key);
}
```
