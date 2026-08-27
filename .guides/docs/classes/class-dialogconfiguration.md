---
title: "Class: DialogConfiguration"
description: "[OverlayConfiguration] that presents its content as a modal dialog via  [Navigator]/[DialogRoute].   Dialogs are usually an intentional choice regardless of platform, so  [adaptiveConversion] is the identity conversion (no adaptation performed).   `Navigator.push` only exposes a [Future], so [OverlayCompleter.remove] and  [OverlayCompleter.dispose] do nothing here. Close the dialog with  `Navigator.pop` or `closeOverlay` instead."
---

```dart
/// [OverlayConfiguration] that presents its content as a modal dialog via
/// [Navigator]/[DialogRoute].
///
/// Dialogs are usually an intentional choice regardless of platform, so
/// [adaptiveConversion] is the identity conversion (no adaptation performed).
///
/// `Navigator.push` only exposes a [Future], so [OverlayCompleter.remove] and
/// [OverlayCompleter.dispose] do nothing here. Close the dialog with
/// `Navigator.pop` or `closeOverlay` instead.
class DialogConfiguration extends OverlayConfiguration {
  /// Whether to use the root navigator.
  final bool useRootNavigator;
  /// Whether tapping outside dismisses the dialog.
  final bool barrierDismissible;
  /// Color of the backdrop barrier.
  final Color? barrierColor;
  /// Semantic label for the barrier.
  final String? barrierLabel;
  /// Whether to respect device safe areas.
  final bool useSafeArea;
  /// Settings for the route.
  final RouteSettings? routeSettings;
  /// Anchor point for transitions.
  final Offset? anchorPoint;
  /// Focus traversal edge behavior.
  final TraversalEdgeBehavior? traversalEdgeBehavior;
  /// Dialog alignment, defaults to center.
  final AlignmentGeometry? alignment;
  /// Whether to display in full-screen mode.
  final bool fullScreen;
  /// Creates a [DialogConfiguration].
  const DialogConfiguration({this.useRootNavigator = true, this.barrierDismissible = true, this.barrierColor, this.barrierLabel, this.useSafeArea = true, this.routeSettings, this.anchorPoint, this.traversalEdgeBehavior, this.alignment, this.fullScreen = false});
  OverlayCompleter<T?> show<T>(BuildContext context, WidgetBuilder builder);
}
```
