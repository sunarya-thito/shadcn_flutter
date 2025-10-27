---
title: "Class: KeyedTabChildWidget"
description: "Reference for KeyedTabChildWidget"
---

```dart
class KeyedTabChildWidget<T> extends TabChildWidget with KeyedTabChild<T> {
  KeyedTabChildWidget({required T key, required super.child, super.indexed});
  ValueKey<T> get key;
  T get tabKey;
}
```
