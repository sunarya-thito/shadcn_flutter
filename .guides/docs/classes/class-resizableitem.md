---
title: "Class: ResizableItem"
description: "Represents a resizable item in a resizable layout."
---

```dart
/// Represents a resizable item in a resizable layout.
///
/// Each item has a current size, minimum/maximum constraints, and can be
/// collapsed to a smaller size. Items can be marked as non-resizable.
class ResizableItem {
  /// Minimum size this item can be resized to.
  final double min;
  /// Maximum size this item can be resized to.
  final double max;
  /// Whether this item is currently in collapsed state.
  final bool collapsed;
  /// Size of the item when collapsed. If null, collapsed size is 0.
  final double? collapsedSize;
  /// Whether this item can be resized.
  final bool resizable;
  /// Creates a resizable item with the given constraints.
  ///
  /// [value] is the initial size of the item.
  /// [min] is the minimum size (defaults to 0).
  /// [max] is the maximum size (defaults to infinity).
  /// [collapsed] indicates if the item starts collapsed.
  /// [collapsedSize] is the size when collapsed (defaults to 0 if null).
  /// [resizable] indicates if the item can be resized (defaults to true).
  ResizableItem({required double value, this.min = 0, this.max = double.infinity, this.collapsed = false, this.collapsedSize, this.resizable = true});
  /// Whether this item is collapsed after resizing operations.
  bool get newCollapsed;
  /// The size of this item after resizing operations.
  double get newValue;
  /// The current size of this item before any resize operations.
  double get value;
  String toString();
}
```
