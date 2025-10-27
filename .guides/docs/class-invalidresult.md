---
title: "Class: InvalidResult"
description: "Reference for InvalidResult"
---

```dart
class InvalidResult extends ValidationResult {
  final String message;
  const InvalidResult(this.message, {required super.state});
  const InvalidResult.attached(this.message, {required FormKey key, required super.state});
  FormKey get key;
  InvalidResult attach(FormKey key);
}
```
