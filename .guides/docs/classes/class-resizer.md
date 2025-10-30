---
title: "Class: Resizer"
description: "Manages the resizing of multiple [ResizableItem]s in a layout."
---

```dart
/// Manages the resizing of multiple [ResizableItem]s in a layout.
///
/// This class handles complex resize operations including:
/// - Dragging dividers between items
/// - Expanding and collapsing items
/// - Borrowing and redistributing space between items
/// - Respecting min/max constraints
class Resizer {
  /// The list of resizable items being managed.
  final List<ResizableItem> items;
  /// Ratio threshold for collapsing an item (0.0 to 1.0).
  /// When an item gets smaller than `min + (collapsedSize - min) * collapseRatio`,
  /// it will collapse.
  final double collapseRatio;
  /// Ratio threshold for expanding a collapsed item (0.0 to 1.0).
  /// When dragging past `(min - collapsedSize) * expandRatio`,
  /// a collapsed item will expand.
  final double expandRatio;
  /// Creates a resizer for the given [items].
  ///
  /// [collapseRatio] controls when items collapse (defaults to 0.5).
  /// [expandRatio] controls when collapsed items expand (defaults to 0.5).
  Resizer(this.items, {this.collapseRatio = 0.5, this.expandRatio = 0.5});
  /// Attempts to expand an item at [index] by [delta] in the given [direction].
  ///
  /// [direction] can be -1 (borrow from left), 0 (borrow from both sides),
  /// or 1 (borrow from right).
  /// Returns true if the expansion was successful.
  bool attemptExpand(int index, int direction, double delta);
  /// Attempts to collapse an item at [index] in the given [direction].
  ///
  /// [direction] can be -1 (give space to left), 0 (give to both sides),
  /// or 1 (give space to right).
  /// Returns true if the collapse was successful.
  bool attemptCollapse(int index, int direction);
  /// Attempts to expand a collapsed item at [index] in the given [direction].
  ///
  /// [direction] can be -1 (borrow from left), 0 (borrow from both sides),
  /// or 1 (borrow from right).
  /// Returns true if the expansion was successful.
  bool attemptExpandCollapsed(int index, int direction);
  /// Handles dragging a divider at [index] by [delta] pixels.
  ///
  /// This is the main method for interactive resizing. It redistributes space
  /// between items, handles collapsing/expanding, and respects constraints.
  /// The divider at [index] is between item [index-1] and item [index].
  void dragDivider(int index, double delta);
  /// Resets all items to their original state.
  ///
  /// Clears any pending resize operations and restores items to their
  /// original values and collapsed states.
  void reset();
}
```
