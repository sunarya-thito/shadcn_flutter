---
title: "Class: PopoverLayoutRender"
description: "Custom render object for popover layout positioning."
---

```dart
/// Custom render object for popover layout positioning.
///
/// Handles the low-level layout calculations for positioning popover content
/// relative to an anchor with automatic constraint adjustments and inversion
/// when the popover would overflow the viewport.
class PopoverLayoutRender extends RenderShiftedBox {
  /// Creates a popover layout render object.
  ///
  /// All parameters control how the popover is positioned and sized relative
  /// to its anchor.
  PopoverLayoutRender({RenderBox? child, required Alignment alignment, required Offset? position, required Alignment anchorAlignment, required PopoverConstraint widthConstraint, required PopoverConstraint heightConstraint, Size? anchorSize, Offset? offset, EdgeInsets margin = const EdgeInsets.all(8), required double scale, required Alignment scaleAlignment, FilterQuality? filterQuality, bool allowInvertHorizontal = true, bool allowInvertVertical = true});
  Size computeDryLayout(covariant BoxConstraints constraints);
  bool hitTest(BoxHitTestResult result, {required Offset position});
  bool hitTestChildren(BoxHitTestResult result, {required Offset position});
  void applyPaintTransform(RenderBox child, Matrix4 transform);
  bool get alwaysNeedsCompositing;
  void paint(PaintingContext context, Offset offset);
  /// Computes appropriate box constraints for the popover child.
  ///
  /// Applies width and height constraint strategies to the child based on
  /// anchor size, viewport constraints, and margin settings.
  ///
  /// Parameters:
  /// - [constraints]: The incoming constraints from parent
  ///
  /// Returns box constraints with min/max values for width and height.
  BoxConstraints getConstraintsForChild(BoxConstraints constraints);
  void performLayout();
}
```
