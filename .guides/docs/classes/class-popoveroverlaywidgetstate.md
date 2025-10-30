---
title: "Class: PopoverOverlayWidgetState"
description: "State class for [PopoverOverlayWidget] managing popover positioning and lifecycle."
---

```dart
/// State class for [PopoverOverlayWidget] managing popover positioning and lifecycle.
///
/// Handles dynamic positioning, anchor tracking, size constraints, and
/// animation for popover overlays. Implements [OverlayHandlerStateMixin]
/// for standard overlay lifecycle management.
class PopoverOverlayWidgetState extends State<PopoverOverlayWidget> with SingleTickerProviderStateMixin, OverlayHandlerStateMixin {
  set offset(Offset? offset);
  void initState();
  Future<void> close([bool immediate = false]);
  void closeLater();
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
  /// Gets the anchor build context.
  BuildContext get anchorContext;
  /// Gets whether horizontal inversion is allowed.
  bool get allowInvertHorizontal;
  /// Gets whether vertical inversion is allowed.
  bool get allowInvertVertical;
  /// Gets the layer link for positioning.
  LayerLink? get layerLink;
  /// Sets the layer link for positioning.
  ///
  /// Updates the layer link and manages ticker state for anchor tracking.
  set layerLink(LayerLink? value);
  set alignment(AlignmentGeometry value);
  /// Sets the popover position.
  ///
  /// Updates the explicit position and triggers a rebuild.
  set position(Offset? value);
  set anchorAlignment(AlignmentGeometry value);
  set widthConstraint(PopoverConstraint value);
  set heightConstraint(PopoverConstraint value);
  set margin(EdgeInsetsGeometry? value);
  set follow(bool value);
  set anchorContext(BuildContext value);
  set allowInvertHorizontal(bool value);
  set allowInvertVertical(bool value);
  void dispose();
  Widget build(BuildContext context);
  Future<void> closeWithResult<X>([X? value]);
}
```
