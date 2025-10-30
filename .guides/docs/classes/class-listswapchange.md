---
title: "Class: ListSwapChange"
description: "A list change that swaps two items."
---

```dart
/// A list change that swaps two items.
///
/// Exchanges the items at positions [from] and [to] in the list.
class ListSwapChange<T> extends ListChange<T> {
  /// The source index.
  final int from;
  /// The destination index.
  final int to;
  /// Creates a [ListSwapChange] that swaps items at [from] and [to].
  const ListSwapChange(this.from, this.to);
  void apply(List<T> list);
}
```
