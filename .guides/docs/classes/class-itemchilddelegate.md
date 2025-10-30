---
title: "Class: ItemChildDelegate"
description: "Abstract delegate for providing items to an item picker."
---

```dart
/// Abstract delegate for providing items to an item picker.
///
/// Defines an interface for accessing items by index, used by [ItemPickerLayout]
/// to build the list or grid of items. Concrete implementations include
/// [ItemList] for fixed arrays and [ItemBuilder] for lazy generation.
///
/// See also:
/// - [ItemList], which wraps a fixed list of items.
/// - [ItemBuilder], which generates items on demand.
abstract class ItemChildDelegate<T> {
  /// Creates an [ItemChildDelegate].
  const ItemChildDelegate();
  /// The total number of items, or null if infinite or unknown.
  int? get itemCount;
  /// Retrieves the item at the specified index.
  ///
  /// Parameters:
  /// - [index] (`int`, required): The index of the item.
  ///
  /// Returns: The item at the index, or null if not available.
  T? operator [](int index);
}
```
