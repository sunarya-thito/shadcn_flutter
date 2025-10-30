---
title: "Class: ItemList"
description: "A delegate that wraps a fixed list of items."
---

```dart
/// A delegate that wraps a fixed list of items.
///
/// Provides items from a pre-defined `List<T>`.
///
/// Example:
/// ```dart
/// ItemList<String>(['Apple', 'Banana', 'Cherry'])
/// ```
class ItemList<T> extends ItemChildDelegate<T> {
  /// The list of items.
  final List<T> items;
  /// Creates an [ItemList].
  ///
  /// Parameters:
  /// - [items] (`List<T>`, required): The items to provide.
  const ItemList(this.items);
  int get itemCount;
  T operator [](int index);
}
```
