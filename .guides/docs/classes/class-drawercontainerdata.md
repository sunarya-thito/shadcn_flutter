---
title: "Class: DrawerContainerData"
description: "The configuration for a [DrawerContainer], provided to descendants via a  [Data] widget. A [DrawerContainer] reads this and builds the appropriate  raw container (drawer or sheet) around its child.   This lets a content builder wrap arbitrary content in a bare  `DrawerContainer(child: ...)` without threading every visual parameter  through the builder."
---

```dart
/// The configuration for a [DrawerContainer], provided to descendants via a
/// [Data] widget. A [DrawerContainer] reads this and builds the appropriate
/// raw container (drawer or sheet) around its child.
///
/// This lets a content builder wrap arbitrary content in a bare
/// `DrawerContainer(child: ...)` without threading every visual parameter
/// through the builder.
class DrawerContainerData {
  /// The resolved position.
  final OverlayPosition position;
  /// The measured content size.
  final Size size;
  /// The stack index (0 = top-most).
  final int stackIndex;
  /// Whether the container expands along the cross axis.
  final bool expands;
  /// Whether to lay out the draggable content.
  final bool draggable;
  /// Whether to show the drag handle.
  final bool showDragHandle;
  /// Explicit drag handle size.
  final Size? dragHandleSize;
  /// Corner radius override.
  final BorderRadiusGeometry? borderRadius;
  /// Inner content padding.
  final EdgeInsets padding;
  /// Outer margin.
  final EdgeInsets margin;
  /// Surface opacity.
  final double? surfaceOpacity;
  /// Surface blur.
  final double? surfaceBlur;
  /// Barrier color.
  final Color? barrierColor;
  /// Gap before the drag handle.
  final double? gapBeforeDragger;
  /// Gap after the drag handle.
  final double? gapAfterDragger;
  /// Size constraints.
  final BoxConstraints? constraints;
  /// Alignment within constraints.
  final AlignmentGeometry? alignment;
  /// Fade animation driving the [ModalBackdrop].
  final Animation<double>? fadeAnimation;
  /// Extra freed space consumed on the outer edge.
  final Size extraSize;
  /// Live overscroll in logical pixels.
  final double overscroll;
  /// Creates a drawer container configuration.
  const DrawerContainerData({required this.position, required this.size, required this.stackIndex, this.expands = false, this.draggable = true, this.showDragHandle = true, this.dragHandleSize, this.borderRadius, this.padding = EdgeInsets.zero, this.margin = EdgeInsets.zero, this.surfaceOpacity, this.surfaceBlur, this.barrierColor, this.gapBeforeDragger, this.gapAfterDragger, this.constraints, this.alignment, this.fadeAnimation, this.extraSize = Size.zero, this.overscroll = 0});
  /// Builds a [DrawerRawContainer] around [child] using this configuration.
  Widget buildDrawer(Widget child, {double startPadding = 0, double endPadding = 0, AxisSize? crossAxisSize, double crossAxisAlignment = 0});
  /// Builds a [SheetRawContainer] around [child] using this configuration.
  Widget buildSheet(Widget child, {double startPadding = 0, double endPadding = 0, AxisSize? crossAxisSize, double crossAxisAlignment = 0});
}
```
