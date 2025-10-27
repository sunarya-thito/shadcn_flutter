---
title: "Class: KeyedTabItem"
description: "Reference for KeyedTabItem"
---

```dart
class KeyedTabItem<T> extends TabItem with KeyedTabChild<T> {
  KeyedTabItem({required T key, required super.child});
  ValueKey<T> get key;
  T get tabKey;
}
```
