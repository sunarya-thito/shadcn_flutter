---
title: "Class: FullScreenDialogOverlayHandler"
description: "Full-screen variant of the dialog overlay handler."
---

```dart
/// Full-screen variant of the dialog overlay handler.
///
/// Similar to [DialogOverlayHandler] but specifically designed for full-screen
/// modal presentations. Removes padding and adjusts styling to fill the entire
/// screen while maintaining proper overlay management and animation behavior.
///
/// Features:
/// - Full-screen modal presentation
/// - Edge-to-edge content display
/// - Maintained overlay architecture
/// - Proper animation handling
/// - Theme inheritance
///
/// Example:
/// ```dart
/// const FullScreenDialogOverlayHandler().show<bool>(
///   context: context,
///   alignment: Alignment.center,
///   builder: (context) => FullScreenForm(),
/// );
/// ```
class FullScreenDialogOverlayHandler extends OverlayHandler {
  /// Checks if the current context is within a dialog overlay.
  ///
  /// Returns `true` if the context is inside a dialog managed by
  /// this overlay handler.
  static bool isDialogOverlay(BuildContext context);
  /// Creates a [FullScreenDialogOverlayHandler].
  ///
  /// Example:
  /// ```dart
  /// const FullScreenDialogOverlayHandler()
  /// ```
  const FullScreenDialogOverlayHandler();
  OverlayCompleter<T> show<T>({required BuildContext context, required AlignmentGeometry alignment, required WidgetBuilder builder, Offset? position, AlignmentGeometry? anchorAlignment, PopoverConstraint widthConstraint = PopoverConstraint.flexible, PopoverConstraint heightConstraint = PopoverConstraint.flexible, Key? key, bool rootOverlay = true, bool modal = true, bool barrierDismissable = true, Clip clipBehavior = Clip.none, Object? regionGroupId, Offset? offset, AlignmentGeometry? transitionAlignment, EdgeInsetsGeometry? margin, bool follow = true, bool consumeOutsideTaps = true, ValueChanged<PopoverOverlayWidgetState>? onTickFollow, bool allowInvertHorizontal = true, bool allowInvertVertical = true, bool dismissBackdropFocus = true, Duration? showDuration, Duration? dismissDuration, OverlayBarrier? overlayBarrier, LayerLink? layerLink});
}
```
