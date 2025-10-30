---
title: "Class: SeparatedIterator"
description: "An iterator that yields elements with separators between them."
---

```dart
/// An iterator that yields elements with separators between them.
///
/// This iterator wraps an existing iterator and produces elements from the
/// source with a separator value inserted between each pair of adjacent
/// elements.
///
/// ## Type Parameters
///
/// * [T] - The type of elements being iterated.
///
/// ## Overview
///
/// [SeparatedIterator] is used internally by [SeparatedIterable]. It maintains
/// state to alternate between source elements and separator values.
///
/// ## Example
///
/// ```dart
/// final iterator = SeparatedIterator([1, 2, 3].iterator, 0);
///
/// while (iterator.moveNext()) {
///   print(iterator.current); // Prints: 1, 0, 2, 0, 3
/// }
/// ```
class SeparatedIterator<T> implements Iterator<T> {
  /// Creates a separated iterator.
  ///
  /// ## Parameters
  ///
  /// * [_iterator] - The source iterator to separate.
  /// * [_separator] - The separator value to insert between elements.
  SeparatedIterator(this._iterator, this._separator);
  T get current;
  bool moveNext();
}
```
