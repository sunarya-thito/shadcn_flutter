---
title: "Class: ListChange"
description: "Base class for list modification operations."
---

```dart
/// Base class for list modification operations.
///
/// Extend this class to create custom list change types. Each change
/// implements [apply] to modify a list in a specific way.
abstract class ListChange<T> {
  /// Creates a [ListChange].
  const ListChange();
  /// Applies this change to the given [list].
  ///
  /// Parameters:
  /// - [list] (`List<T>`, required): The list to modify.
  void apply(List<T> list);
}
```
