---
title: "Class: PopoverLayout"
description: "Custom layout widget for positioning popover content."
---

```dart
/// Custom layout widget for positioning popover content.
///
/// Handles popover positioning with alignment, sizing constraints, and
/// automatic inversion when content would overflow screen bounds.
class PopoverLayout extends SingleChildRenderObjectWidget {
  /// Popover alignment relative to anchor.
  final Alignment alignment;
  /// Anchor alignment for positioning.
  final Alignment anchorAlignment;
  /// Explicit position offset (overrides alignment).
  final Offset? position;
  /// Size of the anchor widget.
  final Size? anchorSize;
  /// Width constraint strategy.
  final PopoverConstraint widthConstraint;
  /// Height constraint strategy.
  final PopoverConstraint heightConstraint;
  /// Additional offset from computed position.
  final Offset? offset;
  /// Margin around the popover.
  final EdgeInsets margin;
  /// Scale factor for the popover.
  final double scale;
  /// Alignment point for scaling transformation.
  final Alignment scaleAlignment;
  /// Filter quality for scaled content.
  final FilterQuality? filterQuality;
  /// Whether to allow horizontal position inversion.
  final bool allowInvertHorizontal;
  /// Whether to allow vertical position inversion.
  final bool allowInvertVertical;
  /// Creates a popover layout widget.
  const PopoverLayout({super.key, required this.alignment, required this.position, required this.anchorAlignment, required this.widthConstraint, required this.heightConstraint, this.anchorSize, this.offset, required this.margin, required Widget super.child, required this.scale, required this.scaleAlignment, this.filterQuality, this.allowInvertHorizontal = true, this.allowInvertVertical = true});
  RenderObject createRenderObject(BuildContext context);
  void updateRenderObject(BuildContext context, covariant PopoverLayoutRender renderObject);
}
```
