---
title: "Class: PopoverOverlayWidgetState"
description: "State class for [PopoverOverlayWidget] managing popover positioning and lifecycle.   Handles dynamic positioning, anchor tracking, size constraints, and  animation for popover overlays. Its lifecycle (close/closeLater) and live  configuration updates are driven externally by the [OverlayPopoverEntry]  (an [OverlayCompleter]) returned from [PopoverConfiguration.show]."
---

```dart
/// State class for [PopoverOverlayWidget] managing popover positioning and lifecycle.
///
/// Handles dynamic positioning, anchor tracking, size constraints, and
/// animation for popover overlays. Its lifecycle (close/closeLater) and live
/// configuration updates are driven externally by the [OverlayPopoverEntry]
/// (an [OverlayCompleter]) returned from [PopoverConfiguration.show].
class PopoverOverlayWidgetState extends State<PopoverOverlayWidget> {
  /// The configuration currently applied to this popover, if assigned via
  /// [config].
  OverlayConfiguration? get config;
  /// Applies a new configuration's live-updatable fields (alignment, margin,
  /// width/height constraint, follow, offset, invert permissions), matching
  /// whichever of [PopoverConfiguration], [MenuConfiguration], or
  /// [TooltipConfiguration] it is.
  set config(OverlayConfiguration? value);
  /// Directly updates the margin without going through [config].
  ///
  /// Used for continuous per-frame adjustments during follow (e.g.
  /// [NavigationMenu] recomputing a content-dependent margin on every
  /// [PopoverConfiguration.show]'s `onTickFollow` tick), which is a
  /// different concern from swapping to a new discrete configuration.
  void updateMargin(EdgeInsetsGeometry margin);
  void initState();
  void didUpdateWidget(covariant PopoverOverlayWidget oldWidget);
  /// Gets the anchor widget's size.
  Size? get anchorSize;
  /// Gets the anchor alignment for positioning.
  AlignmentGeometry get anchorAlignment;
  /// Gets the explicit position offset.
  Offset? get position;
  /// Gets the popover alignment.
  AlignmentGeometry get alignment;
  /// Gets the width constraint strategy.
  PopoverConstraint get widthConstraint;
  /// Gets the height constraint strategy.
  PopoverConstraint get heightConstraint;
  /// Gets the position offset.
  Offset? get offset;
  /// Gets the margin around the popover.
  EdgeInsetsGeometry? get margin;
  /// Gets whether the popover follows the anchor on movement.
  bool get follow;
  /// Gets the anchor this popover is positioned/tracked against.
  Anchor get anchor;
  /// Gets whether horizontal inversion is allowed.
  bool get allowInvertHorizontal;
  /// Gets whether vertical inversion is allowed.
  bool get allowInvertVertical;
  /// Sets the popover position.
  ///
  /// Updates the explicit position and triggers a rebuild.
  set position(Offset? value);
  void dispose();
  Widget build(BuildContext context);
}
```
