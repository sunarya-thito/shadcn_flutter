---
title: "Class: SortableListDelegate"
description: "Abstract base for providing items to a sortable list."
---

```dart
/// Abstract base for providing items to a sortable list.
///
/// Implement this class to create custom item sources for sortable lists.
/// Provides item count and item retrieval methods.
abstract class SortableListDelegate<T> {
  /// Creates a [SortableListDelegate].
  const SortableListDelegate();
  /// The number of items in the list.
  ///
  /// Returns `null` for infinite or unknown-length lists.
  int? get itemCount;
  /// Retrieves the item at the specified [index].
  ///
  /// Parameters:
  /// - [context] (`BuildContext`, required): Build context.
  /// - [index] (`int`, required): Item index.
  ///
  /// Returns: `T` — the item data.
  T getItem(BuildContext context, int index);
}
```
