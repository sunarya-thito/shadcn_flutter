---
title: "Class: DialogOverlayHandler"
description: "Overlay handler that manages dialog display using the navigation stack."
---

```dart
/// Overlay handler that manages dialog display using the navigation stack.
///
/// Provides a standardized way to show dialogs through the overlay system
/// with proper theme inheritance, animation handling, and modal behavior.
/// Integrates with the shadcn_flutter overlay architecture for consistent
/// dialog management across the application.
///
/// Features:
/// - Navigation-based dialog management
/// - Theme and data inheritance
/// - Configurable modal barriers
/// - Animation integration
/// - Proper focus management
///
/// Example:
/// ```dart
/// const DialogOverlayHandler().show<String>(
///   context: context,
///   alignment: Alignment.center,
///   builder: (context) => MyCustomDialog(),
/// );
/// ```
class DialogOverlayHandler extends OverlayHandler {
  /// Checks if the current context is within a dialog overlay.
  ///
  /// Returns `true` if the context is inside a dialog managed by
  /// this overlay handler.
  static bool isDialogOverlay(BuildContext context);
  /// Creates a [DialogOverlayHandler].
  ///
  /// Example:
  /// ```dart
  /// const DialogOverlayHandler()
  /// ```
  const DialogOverlayHandler();
  OverlayCompleter<T> show<T>({required BuildContext context, required AlignmentGeometry alignment, required WidgetBuilder builder, Offset? position, AlignmentGeometry? anchorAlignment, PopoverConstraint widthConstraint = PopoverConstraint.flexible, PopoverConstraint heightConstraint = PopoverConstraint.flexible, Key? key, bool rootOverlay = true, bool modal = true, bool barrierDismissable = true, Clip clipBehavior = Clip.none, Object? regionGroupId, Offset? offset, AlignmentGeometry? transitionAlignment, EdgeInsetsGeometry? margin, bool follow = true, bool consumeOutsideTaps = true, ValueChanged<PopoverOverlayWidgetState>? onTickFollow, bool allowInvertHorizontal = true, bool allowInvertVertical = true, bool dismissBackdropFocus = true, Duration? showDuration, Duration? dismissDuration, OverlayBarrier? overlayBarrier, LayerLink? layerLink});
}
```
