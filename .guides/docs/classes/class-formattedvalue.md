---
title: "Class: FormattedValue"
description: "Reference for FormattedValue"
---

```dart
class FormattedValue {
  final List<FormattedValuePart> parts;
  const FormattedValue([this.parts = const []]);
  Iterable<FormattedValuePart> get values;
  FormattedValuePart? operator [](int index);
  String toString();
  bool operator ==(Object other);
  int get hashCode;
}
```
