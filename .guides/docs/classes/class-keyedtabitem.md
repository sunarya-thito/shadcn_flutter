---
title: "Class: KeyedTabItem"
description: "A keyed tab item widget."
---

```dart
/// A keyed tab item widget.
///
/// Similar to [TabItem] but includes a unique key for identification.
class KeyedTabItem<T> extends TabItem with KeyedTabChild<T> {
  /// Creates a [KeyedTabItem].
  ///
  /// Parameters:
  /// - [key] (`T`, required): unique key for this tab
  /// - [child] (`Widget`, required): content to display in this tab
  KeyedTabItem({required T key, required super.child});
  ValueKey<T> get key;
  T get tabKey;
}
```
