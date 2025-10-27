---
title: "Class: CompareTo"
description: "Reference for CompareTo"
---

```dart
class CompareTo<T extends Comparable<T>> extends Validator<T> {
  final T? value;
  final CompareType type;
  final String? message;
  const CompareTo(this.value, this.type, {this.message});
  const CompareTo.equal(this.value, {this.message});
  const CompareTo.greater(this.value, {this.message});
  const CompareTo.greaterOrEqual(this.value, {this.message});
  const CompareTo.less(this.value, {this.message});
  const CompareTo.lessOrEqual(this.value, {this.message});
  FutureOr<ValidationResult?> validate(BuildContext context, T? value, FormValidationMode state);
  bool operator ==(Object other);
  int get hashCode;
}
```
