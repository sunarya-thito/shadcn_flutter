---
title: "Class: FormValueState"
description: "Reference for FormValueState"
---

```dart
class FormValueState<T> {
  final T? value;
  final Validator<T>? validator;
  FormValueState({this.value, this.validator});
  String toString();
  bool operator ==(Object other);
  int get hashCode;
}
```
