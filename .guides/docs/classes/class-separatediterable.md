---
title: "Class: SeparatedIterable"
description: "An iterable that inserts a separator between elements of another iterable."
---

```dart
/// An iterable that inserts a separator between elements of another iterable.
///
/// This class wraps an existing iterable and lazily produces elements with
/// a separator value inserted between each pair of adjacent elements.
///
/// ## Type Parameters
///
/// * [T] - The type of elements in the iterable.
///
/// ## Overview
///
/// Use [SeparatedIterable] when you need to iterate over a collection with
/// separators but don't want to allocate a new list. The separation happens
/// lazily during iteration.
///
/// ## Example
///
/// ```dart
/// final numbers = [1, 2, 3, 4];
/// final separated = SeparatedIterable(numbers, 0);
///
/// print(separated.toList()); // [1, 0, 2, 0, 3, 0, 4]
/// ```
///
/// See also:
///
/// * [mutateSeparated] for in-place list mutation with separators.
class SeparatedIterable<T> extends Iterable<T> {
  /// Creates a separated iterable.
  ///
  /// ## Parameters
  ///
  /// * [_iterable] - The source iterable to separate.
  /// * [_separator] - The separator value to insert between elements.
  SeparatedIterable(this._iterable, this._separator);
  Iterator<T> get iterator;
}
```
