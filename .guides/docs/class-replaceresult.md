---
title: "Class: ReplaceResult"
description: "Reference for ReplaceResult"
---

```dart
class ReplaceResult<T> extends ValidationResult {
  final T value;
  const ReplaceResult(this.value, {required super.state});
  const ReplaceResult.attached(this.value, {required FormKey key, required super.state});
  FormKey get key;
  ReplaceResult<T> attach(FormKey key);
}
```
