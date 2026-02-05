---
title: "Mixin: PaintOrderMixin"
description: "Mixin for render objects that support custom paint order."
---

```dart
/// Mixin for render objects that support custom paint order.
///
/// This mixin provides the sorting logic for painting children in a custom order
/// based on their [PaintOrderParentDataMixin.paintOrder] property.
mixin PaintOrderMixin on rendering.RenderBox {
  /// The first child in the sorted paint order.
  rendering.RenderBox? firstSortedChild;
  /// The last child in the sorted paint order.
  rendering.RenderBox? lastSortedChild;
  /// Get the first child - must be implemented by the render object.
  rendering.RenderBox? get paintOrderFirstChild;
  /// Builds a sorted linked list of children based on their paint order.
  ///
  /// Children without a paint order default to 0 and are painted in their
  /// natural layout order. Children with a positive paint order are painted
  /// above them.
  void buildSortedLinkedList();
  /// Paints children in sorted paint order.
  void paintSorted(rendering.PaintingContext context, Offset offset);
  /// Hit tests children in reverse sorted paint order (top-most first).
  bool hitTestSortedChildren(rendering.BoxHitTestResult result, {required Offset position});
}
```
