---
title: "Class: SubmissionResult"
description: "Reference for SubmissionResult"
---

```dart
class SubmissionResult {
  final Map<FormKey, Object?> values;
  final Map<FormKey, ValidationResult> errors;
  const SubmissionResult(this.values, this.errors);
  String toString();
  bool operator ==(Object other);
  int get hashCode;
}
```
