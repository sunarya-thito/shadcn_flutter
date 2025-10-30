---
title: "Class: SortableChildBuilderDelegate"
description: "A delegate that builds items on demand."
---

```dart
/// A delegate that builds items on demand.
///
/// Creates items using a builder function rather than from a fixed list.
/// Useful for large or lazily-generated item sets.
class SortableChildBuilderDelegate<T> extends SortableListDelegate<T> {
  /// The number of items, or `null` for infinite lists.
  final int? itemCount;
  /// Builder function for creating items.
  final SortableItemBuilder<T> builder;
  /// Creates a [SortableChildBuilderDelegate].
  ///
  /// Parameters:
  /// - [itemCount] (`int?`, optional): Number of items, or `null` for infinite.
  /// - [builder] (`SortableItemBuilder<T>`, required): Item builder function.
  const SortableChildBuilderDelegate({this.itemCount, required this.builder});
  T getItem(BuildContext context, int index);
}
```
