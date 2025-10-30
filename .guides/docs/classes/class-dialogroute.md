---
title: "Class: DialogRoute"
description: "Custom route implementation for shadcn_flutter dialogs."
---

```dart
/// Custom route implementation for shadcn_flutter dialogs.
///
/// Extends [RawDialogRoute] to provide consistent dialog behavior with
/// proper theme inheritance, data capture, and transition animations.
/// Handles both standard and full-screen dialog presentations.
///
/// Features:
/// - Theme and data inheritance across navigation boundaries
/// - Configurable alignment and positioning
/// - Full-screen mode support
/// - Custom transition animations
/// - Safe area integration
///
/// This class is typically not used directly - use [showDialog] instead.
class DialogRoute<T> extends RawDialogRoute<T> {
  /// Captured data from the launching context.
  final CapturedData? data;
  /// Alignment for positioning the dialog.
  final AlignmentGeometry alignment;
  /// Whether the dialog should display in full-screen mode.
  final bool fullScreen;
  /// Creates a [DialogRoute].
  ///
  /// Parameters:
  /// - [context] (`BuildContext`, required): Build context.
  /// - [builder] (`WidgetBuilder`, required): Dialog content builder.
  /// - [themes] (`CapturedThemes?`, optional): Captured theme data.
  /// - [barrierColor] (`Color`, default: transparent): Barrier color.
  /// - [barrierDismissible] (`bool?`, optional): Whether tapping barrier dismisses dialog.
  /// - [barrierLabel] (`String?`, optional): Semantic label for barrier.
  /// - [useSafeArea] (`bool`, default: `true`): Whether to respect safe area.
  /// - [settings] (`RouteSettings?`, optional): Route settings.
  /// - [anchorPoint] (`Offset?`, optional): Anchor point for route.
  /// - [traversalEdgeBehavior] (`TraversalEdgeBehavior?`, optional): Traversal behavior.
  /// - [alignment] (`AlignmentGeometry`, required): Dialog alignment.
  /// - [transitionBuilder] (`RouteTransitionsBuilder`, required): Transition builder.
  /// - [fullScreen] (`bool`, default: `false`): Full-screen mode.
  /// - [data] (`CapturedData?`, optional): Captured data.
  DialogRoute({required BuildContext context, required WidgetBuilder builder, CapturedThemes? themes, super.barrierColor = const Color.fromRGBO(0, 0, 0, 0), super.barrierDismissible, String? barrierLabel, bool useSafeArea = true, super.settings, super.anchorPoint, super.traversalEdgeBehavior, required this.alignment, required super.transitionBuilder, this.fullScreen = false, this.data});
}
```
