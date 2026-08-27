---
title: "Class: PopoverLayout"
description: "Custom layout widget for positioning popover content.   Handles popover positioning with alignment, sizing constraints, and  automatic inversion when content would overflow screen bounds."
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
  /// Resolver for the anchor's live [RenderBox], enabling composite-time
  /// tracking. When non-null, the popover re-measures the anchor's position on
  /// every scene build and re-applies margin/invert live (see
  /// [PopoverLayoutRender]); when null it uses the static [position].
  final RenderBox? Function()? liveAnchor;
  /// Called (post-frame) when [liveAnchor] can no longer be resolved — i.e. the
  /// anchor was removed — so the popover can close.
  final VoidCallback? onAnchorLost;
  /// Creates a popover layout widget.
  const PopoverLayout({super.key, required this.alignment, required this.position, required this.anchorAlignment, required this.widthConstraint, required this.heightConstraint, this.anchorSize, this.offset, required this.margin, required Widget super.child, required this.scale, required this.scaleAlignment, this.filterQuality, this.allowInvertHorizontal = true, this.allowInvertVertical = true, this.liveAnchor, this.onAnchorLost});
  RenderObject createRenderObject(BuildContext context);
  void updateRenderObject(BuildContext context, covariant PopoverLayoutRender renderObject);
}
```
