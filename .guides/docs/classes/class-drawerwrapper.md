---
title: "Class: DrawerWrapper"
description: "Internal wrapper widget for drawer/sheet rendering."
---

```dart
/// Internal wrapper widget for drawer/sheet rendering.
///
/// Manages the visual presentation and interaction behavior of drawer overlays.
/// Handles sizing, positioning, drag interactions, and animations.
class DrawerWrapper extends StatefulWidget {
  /// Position of the drawer on screen.
  final OverlayPosition position;
  /// Content widget displayed in the drawer.
  final Widget child;
  /// Whether the drawer expands to fill available space.
  final bool expands;
  /// Whether the drawer can be dragged to resize or dismiss.
  final bool draggable;
  /// Additional size beyond the content size.
  final Size extraSize;
  /// Size of the drawer.
  final Size size;
  /// Whether to show the drag handle.
  final bool showDragHandle;
  /// Border radius for the drawer.
  final BorderRadiusGeometry? borderRadius;
  /// Size of the drag handle.
  final Size? dragHandleSize;
  /// Internal padding of the drawer content.
  final EdgeInsets padding;
  /// Surface opacity for the drawer background.
  final double? surfaceOpacity;
  /// Surface blur amount for the drawer background.
  final double? surfaceBlur;
  /// Color of the barrier behind the drawer.
  final Color? barrierColor;
  /// Z-index for stacking multiple drawers.
  final int stackIndex;
  /// Gap before the drag handle.
  final double? gapBeforeDragger;
  /// Gap after the drag handle.
  final double? gapAfterDragger;
  /// Optional animation controller for custom animations.
  final AnimationController? animationController;
  /// Size constraints for the drawer.
  final BoxConstraints? constraints;
  /// Alignment of the drawer content.
  final AlignmentGeometry? alignment;
  /// Creates a [DrawerWrapper].
  const DrawerWrapper({super.key, required this.position, required this.child, this.expands = false, this.draggable = true, this.extraSize = Size.zero, required this.size, this.showDragHandle = true, this.borderRadius, this.dragHandleSize, this.padding = EdgeInsets.zero, this.surfaceOpacity, this.surfaceBlur, this.barrierColor, this.gapBeforeDragger, this.gapAfterDragger, required this.stackIndex, this.animationController, this.constraints, this.alignment});
  State<DrawerWrapper> createState();
}
```
