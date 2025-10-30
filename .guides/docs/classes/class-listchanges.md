---
title: "Class: ListChanges"
description: "Represents a collection of list modifications."
---

```dart
/// Represents a collection of list modifications.
///
/// Encapsulates multiple [ListChange] objects that can be applied to a list
/// in sequence. Useful for batch operations or undo/redo functionality.
class ListChanges<T> {
  /// The list of individual changes to apply.
  final List<ListChange<T>> changes;
  /// Creates a [ListChanges] with the specified [changes].
  const ListChanges(this.changes);
  /// Applies all changes to the given [list] in order.
  ///
  /// Parameters:
  /// - [list] (`List<T>`, required): The list to modify.
  void apply(List<T> list);
}
```
