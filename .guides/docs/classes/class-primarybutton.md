---
title: "Class: PrimaryButton"
description: "Convenience widget for creating a primary button."
---

```dart
/// Convenience widget for creating a primary button.
///
/// [PrimaryButton] is a simplified wrapper around [Button] that automatically
/// applies the primary button style. It provides a cleaner API for the common
/// case of creating primary buttons without manually specifying the style.
///
/// This widget exposes all the same properties as [Button] but defaults to
/// [ButtonStyle.primary] for consistent styling.
///
/// Example:
/// ```dart
/// PrimaryButton(
///   onPressed: () => submitForm(),
///   leading: Icon(Icons.check),
///   child: Text('Submit'),
/// )
/// ```
class PrimaryButton extends StatelessWidget {
  /// The widget displayed as the button's main content.
  final Widget child;
  /// Called when the button is pressed. If `null`, the button is disabled.
  final VoidCallback? onPressed;
  /// Whether the button is enabled. Overrides the `onPressed` check if provided.
  final bool? enabled;
  /// Widget displayed before the [child].
  final Widget? leading;
  /// Widget displayed after the [child].
  final Widget? trailing;
  /// Alignment of the button's content.
  final AlignmentGeometry? alignment;
  /// Size variant of the button (defaults to [ButtonSize.normal]).
  final ButtonSize size;
  /// Density variant affecting spacing (defaults to [ButtonDensity.normal]).
  final ButtonDensity density;
  /// Shape of the button (defaults to [ButtonShape.rectangle]).
  final ButtonShape shape;
  /// Focus node for keyboard focus management.
  final FocusNode? focusNode;
  /// Whether to disable style transition animations (defaults to `false`).
  final bool disableTransition;
  /// Called when hover state changes.
  final ValueChanged<bool>? onHover;
  /// Called when focus state changes.
  final ValueChanged<bool>? onFocus;
  /// Whether to enable haptic/audio feedback.
  final bool? enableFeedback;
  /// Called when primary tap down occurs.
  final GestureTapDownCallback? onTapDown;
  /// Called when primary tap up occurs.
  final GestureTapUpCallback? onTapUp;
  /// Called when primary tap is cancelled.
  final GestureTapCancelCallback? onTapCancel;
  /// Called when secondary tap down occurs.
  final GestureTapDownCallback? onSecondaryTapDown;
  /// Called when secondary tap up occurs.
  final GestureTapUpCallback? onSecondaryTapUp;
  /// Called when secondary tap is cancelled.
  final GestureTapCancelCallback? onSecondaryTapCancel;
  /// Called when tertiary tap down occurs.
  final GestureTapDownCallback? onTertiaryTapDown;
  /// Called when tertiary tap up occurs.
  final GestureTapUpCallback? onTertiaryTapUp;
  /// Called when tertiary tap is cancelled.
  final GestureTapCancelCallback? onTertiaryTapCancel;
  /// Called when long press starts.
  final GestureLongPressStartCallback? onLongPressStart;
  /// Called when long press is released.
  final GestureLongPressUpCallback? onLongPressUp;
  /// Called when long press moves.
  final GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate;
  /// Called when long press ends.
  final GestureLongPressEndCallback? onLongPressEnd;
  /// Called when secondary long press completes.
  final GestureLongPressUpCallback? onSecondaryLongPress;
  /// Called when tertiary long press completes.
  final GestureLongPressUpCallback? onTertiaryLongPress;
  /// Creates a primary button with the specified properties.
  const PrimaryButton({super.key, required this.child, this.onPressed, this.enabled, this.leading, this.trailing, this.alignment, this.size = ButtonSize.normal, this.density = ButtonDensity.normal, this.shape = ButtonShape.rectangle, this.focusNode, this.disableTransition = false, this.onHover, this.onFocus, this.enableFeedback, this.onTapDown, this.onTapUp, this.onTapCancel, this.onSecondaryTapDown, this.onSecondaryTapUp, this.onSecondaryTapCancel, this.onTertiaryTapDown, this.onTertiaryTapUp, this.onTertiaryTapCancel, this.onLongPressStart, this.onLongPressUp, this.onLongPressMoveUpdate, this.onLongPressEnd, this.onSecondaryLongPress, this.onTertiaryLongPress});
  Widget build(BuildContext context);
}
```
