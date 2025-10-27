---
title: "Class: ObjectFormHandler"
description: "Reference for ObjectFormHandler"
---

```dart
abstract class ObjectFormHandler<T> {
  T? get value;
  set value(T? value);
  void prompt([T? value]);
  Future<void> close();
  static ObjectFormHandler<T> of<T>(BuildContext context);
  static ObjectFormHandler<T> find<T>(BuildContext context);
}
```
