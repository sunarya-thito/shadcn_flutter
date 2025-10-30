---
title: "Extension: ListExtension"
description: "Extension methods for List operations with null-safe variants."
---

```dart
/// Extension methods for List operations with null-safe variants.
extension ListExtension<T> on List<T> {
  /// Finds the first index of an element, returning null if not found.
  ///
  /// Parameters:
  /// - [obj] (T, required): Element to find
  /// - [start] (int): Index to start searching from, defaults to 0
  ///
  /// Returns index or null if not found.
  int? indexOfOrNull(T obj, [int start = 0]);
  /// Finds the last index of an element, returning null if not found.
  ///
  /// Parameters:
  /// - [obj] (T, required): Element to find
  /// - [start] (int?): Index to search backwards from
  ///
  /// Returns last index or null if not found.
  int? lastIndexOfOrNull(T obj, [int? start]);
  /// Finds the first index where test is true, returning null if not found.
  ///
  /// Parameters:
  /// - [test] (`Predicate<T>`, required): Test function
  /// - [start] (int): Index to start searching from, defaults to 0
  ///
  /// Returns index or null if no match found.
  int? indexWhereOrNull(Predicate<T> test, [int start = 0]);
  /// Finds the last index where test is true, returning null if not found.
  ///
  /// Parameters:
  /// - [test] (`Predicate<T>`, required): Test function
  /// - [start] (int?): Index to search backwards from
  ///
  /// Returns last index or null if no match found.
  int? lastIndexWhereOrNull(Predicate<T> test, [int? start]);
  /// Moves an element to a target index in the list.
  ///
  /// If the element doesn't exist, inserts it at the target index.
  /// If targetIndex >= length, moves element to the end.
  ///
  /// Parameters:
  /// - [element] (T, required): Element to move
  /// - [targetIndex] (int, required): Destination index
  ///
  /// Returns true if operation succeeded.
  bool swapItem(T element, int targetIndex);
  /// Moves the first element matching test to a target index.
  ///
  /// Returns false if no element matches the test.
  ///
  /// Parameters:
  /// - [test] (`Predicate<T>`, required): Test function to find element
  /// - [targetIndex] (int, required): Destination index
  ///
  /// Returns true if element was found and moved.
  bool swapItemWhere(Predicate<T> test, int targetIndex);
  /// Safely gets an element at index, returning null if out of bounds.
  ///
  /// Parameters:
  /// - [index] (int, required): Index to access
  ///
  /// Returns element at index or null if index is out of bounds.
  T? optGet(int index);
}
```
