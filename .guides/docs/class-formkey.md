---
title: "Class: FormKey"
description: "Reference for FormKey"
---

```dart
class FormKey<T> extends LocalKey {
  final Object key;
  const FormKey(this.key);
  Type get type;
  bool isInstanceOf(dynamic value);
  T? getValue(FormMapValues values);
  T? operator [](FormMapValues values);
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
