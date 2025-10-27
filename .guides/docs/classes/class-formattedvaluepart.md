---
title: "Class: FormattedValuePart"
description: "Reference for FormattedValuePart"
---

```dart
class FormattedValuePart {
  final InputPart part;
  final String? value;
  const FormattedValuePart(this.part, [this.value]);
  FormattedValuePart withValue(String value);
  String toString();
  bool operator ==(Object other);
  int get hashCode;
}
```
