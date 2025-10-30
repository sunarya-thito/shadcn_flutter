---
title: "Class: SortableChildListDelegate"
description: "A delegate that provides items from an explicit list."
---

```dart
/// A delegate that provides items from an explicit list.
///
/// Wraps a fixed [List] of items for use in a sortable list.
class SortableChildListDelegate<T> extends SortableListDelegate<T> {
  /// The list of items.
  final List<T> items;
  /// Builder for creating item widgets.
  final SortableWidgetBuilder<T> builder;
  /// Creates a [SortableChildListDelegate].
  ///
  /// Parameters:
  /// - [items] (`List<T>`, required): The list of items.
  /// - [builder] (`SortableWidgetBuilder<T>`, required): Item widget builder.
  const SortableChildListDelegate(this.items, this.builder);
  int get itemCount;
  T getItem(BuildContext context, int index);
}
```
