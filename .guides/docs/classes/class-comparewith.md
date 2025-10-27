---
title: "Class: CompareWith"
description: "Reference for CompareWith"
---

```dart
class CompareWith<T extends Comparable<T>> extends Validator<T> {
  final FormKey<T> key;
  final CompareType type;
  final String? message;
  const CompareWith(this.key, this.type, {this.message});
  const CompareWith.equal(this.key, {this.message});
  const CompareWith.greater(this.key, {this.message});
  const CompareWith.greaterOrEqual(this.key, {this.message});
  const CompareWith.less(this.key, {this.message});
  const CompareWith.lessOrEqual(this.key, {this.message});
  FutureOr<ValidationResult?> validate(BuildContext context, T? value, FormValidationMode state);
  bool shouldRevalidate(FormKey<dynamic> source);
  bool operator ==(Object other);
  int get hashCode;
}
```
