---
title: "Class: DrawerConfiguration"
description: "[OverlayConfiguration] that presents its content as a side/bottom drawer  (with backdrop transform).   Already the mobile-appropriate mechanism, so [adaptiveConversion] is the  identity conversion (no adaptation performed)."
---

```dart
/// [OverlayConfiguration] that presents its content as a side/bottom drawer
/// (with backdrop transform).
///
/// Already the mobile-appropriate mechanism, so [adaptiveConversion] is the
/// identity conversion (no adaptation performed).
class DrawerConfiguration extends OverlayConfiguration {
  /// The [Anchor] to resolve against ([LinkedAnchor] for an anchor key
  /// registered via [OverlayAnchor], or [ContextAnchor]), if using
  /// anchor-based positioning instead of the [BuildContext] passed to [show].
  final Anchor? anchor;
  /// The edge the drawer slides in from.
  final OverlayPosition position;
  /// Whether the drawer expands to fill available space.
  final bool expands;
  /// Whether the drawer can be dragged to dismiss.
  final bool draggable;
  /// Whether tapping the barrier dismisses the drawer.
  final bool barrierDismissible;
  /// Custom backdrop builder.
  final WidgetBuilder? backdropBuilder;
  /// Whether to respect device safe areas.
  final bool useSafeArea;
  /// Whether to show a drag handle.
  final bool? showDragHandle;
  /// Corner radius for the drawer.
  final BorderRadiusGeometry? borderRadius;
  /// Size of the drag handle.
  final Size? dragHandleSize;
  /// Whether to scale/transform the backdrop.
  final bool transformBackdrop;
  /// Opacity for surface effects.
  final double? surfaceOpacity;
  /// Blur intensity for surface effects.
  final double? surfaceBlur;
  /// Color of the modal barrier.
  final Color? barrierColor;
  /// Custom animation controller.
  final AnimationController? animationController;
  /// Whether to automatically open on creation.
  final bool autoOpen;
  /// Size constraints for the drawer.
  final BoxConstraints? constraints;
  /// Alignment within constraints.
  final AlignmentGeometry? alignment;
  /// Creates a [DrawerConfiguration].
  const DrawerConfiguration({this.anchor, this.position = OverlayPosition.bottom, this.expands = false, this.draggable = true, this.barrierDismissible = true, this.backdropBuilder, this.useSafeArea = true, this.showDragHandle, this.borderRadius, this.dragHandleSize, this.transformBackdrop = true, this.surfaceOpacity, this.surfaceBlur, this.barrierColor, this.animationController, this.autoOpen = true, this.constraints, this.alignment});
  OverlayCompleter<T?> show<T>(BuildContext context, WidgetBuilder builder);
}
```
