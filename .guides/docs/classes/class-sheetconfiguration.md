---
title: "Class: SheetConfiguration"
description: "[OverlayConfiguration] that presents its content as a minimally-styled,  full-extent sheet (no backdrop transform, unlike [DrawerConfiguration]).   Already the mobile-appropriate mechanism, so [adaptiveConversion] is the  identity conversion (no adaptation performed)."
---

```dart
/// [OverlayConfiguration] that presents its content as a minimally-styled,
/// full-extent sheet (no backdrop transform, unlike [DrawerConfiguration]).
///
/// Already the mobile-appropriate mechanism, so [adaptiveConversion] is the
/// identity conversion (no adaptation performed).
class SheetConfiguration extends OverlayConfiguration {
  /// The [Anchor] to resolve against ([LinkedAnchor] for an anchor key
  /// registered via [OverlayAnchor], or [ContextAnchor]), if using
  /// anchor-based positioning instead of the [BuildContext] passed to [show].
  final Anchor? anchor;
  /// The edge the sheet slides in from.
  final OverlayPosition position;
  /// Whether tapping the barrier dismisses the sheet.
  final bool barrierDismissible;
  /// Whether to transform the backdrop.
  final bool transformBackdrop;
  /// Custom backdrop builder.
  final WidgetBuilder? backdropBuilder;
  /// Color of the modal barrier.
  final Color? barrierColor;
  /// Whether the sheet can be dragged to dismiss.
  final bool draggable;
  /// Custom animation controller.
  final AnimationController? animationController;
  /// Whether to automatically open on creation.
  final bool autoOpen;
  /// Size constraints for the sheet.
  final BoxConstraints? constraints;
  /// Alignment within constraints.
  final AlignmentGeometry? alignment;
  /// Whether to respect device safe areas around the sheet.
  ///
  /// Defaults to `false` since [SheetWrapper] handles safe-area padding
  /// itself for the direct-sheet case. [MenuConfiguration] passes `true`
  /// here for its mobile fallback presentation, matching the historical
  /// `SheetOverlayHandler`-as-menu-handler behavior.
  final bool useSafeArea;
  /// Creates a [SheetConfiguration].
  const SheetConfiguration({this.anchor, this.position = OverlayPosition.bottom, this.barrierDismissible = true, this.transformBackdrop = false, this.backdropBuilder, this.barrierColor, this.draggable = false, this.animationController, this.autoOpen = true, this.constraints, this.alignment, this.useSafeArea = false});
  OverlayCompleter<T?> show<T>(BuildContext context, WidgetBuilder builder);
}
```
