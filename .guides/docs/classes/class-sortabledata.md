---
title: "Class: SortableData"
description: "Immutable data wrapper for sortable items in drag-and-drop operations."
---

```dart
/// Immutable data wrapper for sortable items in drag-and-drop operations.
///
/// SortableData wraps the actual data being sorted and provides identity for
/// drag-and-drop operations. Each sortable item must have associated data that
/// uniquely identifies it within the sorting context.
///
/// The class is immutable and uses reference equality for comparison, ensuring
/// that each sortable item maintains its identity throughout drag operations.
/// This is crucial for proper drop validation and handling.
///
/// Type parameter [T] represents the type of data being sorted, which can be
/// any type including primitive types, custom objects, or complex data structures.
///
/// Example:
/// ```dart
/// // Simple string data
/// SortableData<String>('item_1')
///
/// // Complex object data
/// SortableData<TodoItem>(TodoItem(id: 1, title: 'Task 1'))
///
/// // Map data
/// SortableData<Map<String, dynamic>>({'id': 1, 'name': 'Item'})
/// ```
class SortableData<T> {
  /// The actual data being wrapped for sorting operations.
  ///
  /// Type: `T`. This is the data that will be passed to drop handlers and
  /// validation predicates. Can be any type that represents the sortable item.
  final T data;
  /// Creates a [SortableData] wrapper for the given data.
  ///
  /// Wraps the provided data in an immutable container that can be used with
  /// sortable widgets for drag-and-drop operations.
  ///
  /// Parameters:
  /// - [data] (T, required): The data to wrap for sorting operations
  ///
  /// Example:
  /// ```dart
  /// // Wrapping different data types
  /// SortableData('text_item')
  /// SortableData(42)
  /// SortableData(MyCustomObject(id: 1))
  /// ```
  const SortableData(this.data);
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
