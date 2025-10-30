---
title: "Extension: IterableExtension"
description: "Extension adding separator joining for iterables."
---

```dart
/// Extension adding separator joining for iterables.
extension IterableExtension<T> on Iterable<T> {
  /// Joins iterable items with a separator between each.
  ///
  /// Parameters:
  /// - [separator] (`T`, required): Item to insert between elements.
  ///
  /// Returns: `Iterable<T>` — iterable with separators inserted.
  Iterable<T> joinSeparator(T separator);
  /// Joins iterable items with dynamically built separators.
  ///
  /// Each separator is created by calling the builder function.
  ///
  /// Parameters:
  /// - [separator] (`ValueGetter<T>`, required): Builder for separator items.
  ///
  /// Returns: `Iterable<T>` — iterable with separators inserted.
  Iterable<T> buildSeparator(ValueGetter<T> separator);
}
```
