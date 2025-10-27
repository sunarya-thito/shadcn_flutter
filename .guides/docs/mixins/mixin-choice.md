---
title: "Mixin: Choice"
description: "Reference for Choice"
---

```dart
mixin Choice<T> {
  static void choose<T>(BuildContext context, T item);
  static Iterable<T>? getValue<T>(BuildContext context);
  void selectItem(T item);
  Iterable<T>? get value;
}
```
