---
title: "Class: IconButton"
description: "Icon-only button widget with support for multiple visual styles."
---

```dart
/// Icon-only button widget with support for multiple visual styles.
///
/// [IconButton] is optimized for displaying buttons with icon content,
/// using icon-specific density and sizing by default. Supports various
/// button styles through named constructors or the [variance] parameter.
class IconButton extends StatelessWidget {
  /// The icon widget to display in the button.
  final Widget icon;
  /// Called when the button is pressed. If `null`, the button is disabled.
  final VoidCallback? onPressed;
  /// Whether the button is enabled. Overrides the `onPressed` check if provided.
  final bool? enabled;
  /// Widget displayed before the [icon].
  final Widget? leading;
  /// Widget displayed after the [icon].
  final Widget? trailing;
  /// Alignment of the button's content.
  final AlignmentGeometry? alignment;
  /// Size variant of the button (defaults to [ButtonSize.normal]).
  final ButtonSize size;
  /// Density variant affecting spacing (defaults to [ButtonDensity.icon]).
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
  /// The button style variant to apply.
  final AbstractButtonStyle variance;
  /// Creates an icon button with the specified style variance.
  const IconButton({super.key, required this.icon, required this.variance, this.onPressed, this.enabled, this.leading, this.trailing, this.alignment, this.size = ButtonSize.normal, this.density = ButtonDensity.icon, this.shape = ButtonShape.rectangle, this.focusNode, this.disableTransition = false, this.onHover, this.onFocus, this.enableFeedback, this.onTapDown, this.onTapUp, this.onTapCancel, this.onSecondaryTapDown, this.onSecondaryTapUp, this.onSecondaryTapCancel, this.onTertiaryTapDown, this.onTertiaryTapUp, this.onTertiaryTapCancel, this.onLongPressStart, this.onLongPressUp, this.onLongPressMoveUpdate, this.onLongPressEnd, this.onSecondaryLongPress, this.onTertiaryLongPress});
  /// Creates an icon button with primary styling.
  const IconButton.primary({super.key, required this.icon, this.onPressed, this.enabled, this.leading, this.trailing, this.alignment, this.size = ButtonSize.normal, this.focusNode, this.disableTransition = false, this.onHover, this.onFocus, this.enableFeedback, this.onTapDown, this.onTapUp, this.onTapCancel, this.onSecondaryTapDown, this.onSecondaryTapUp, this.onSecondaryTapCancel, this.onTertiaryTapDown, this.onTertiaryTapUp, this.onTertiaryTapCancel, this.onLongPressStart, this.onLongPressUp, this.onLongPressMoveUpdate, this.onLongPressEnd, this.onSecondaryLongPress, this.onTertiaryLongPress, this.variance = ButtonVariance.primary, this.density = ButtonDensity.icon, this.shape = ButtonShape.rectangle});
  /// Creates an icon button with secondary styling.
  const IconButton.secondary({super.key, required this.icon, this.onPressed, this.enabled, this.leading, this.trailing, this.alignment, this.size = ButtonSize.normal, this.focusNode, this.disableTransition = false, this.onHover, this.onFocus, this.enableFeedback, this.onTapDown, this.onTapUp, this.onTapCancel, this.onSecondaryTapDown, this.onSecondaryTapUp, this.onSecondaryTapCancel, this.onTertiaryTapDown, this.onTertiaryTapUp, this.onTertiaryTapCancel, this.onLongPressStart, this.onLongPressUp, this.onLongPressMoveUpdate, this.onLongPressEnd, this.onSecondaryLongPress, this.onTertiaryLongPress, this.variance = ButtonVariance.secondary, this.density = ButtonDensity.icon, this.shape = ButtonShape.rectangle});
  /// Creates an icon button with outline styling.
  const IconButton.outline({super.key, required this.icon, this.onPressed, this.enabled, this.leading, this.trailing, this.alignment, this.size = ButtonSize.normal, this.focusNode, this.disableTransition = false, this.onHover, this.onFocus, this.enableFeedback, this.onTapDown, this.onTapUp, this.onTapCancel, this.onSecondaryTapDown, this.onSecondaryTapUp, this.onSecondaryTapCancel, this.onTertiaryTapDown, this.onTertiaryTapUp, this.onTertiaryTapCancel, this.onLongPressStart, this.onLongPressUp, this.onLongPressMoveUpdate, this.onLongPressEnd, this.onSecondaryLongPress, this.onTertiaryLongPress, this.variance = ButtonVariance.outline, this.density = ButtonDensity.icon, this.shape = ButtonShape.rectangle});
  /// Creates an icon button with ghost styling.
  const IconButton.ghost({super.key, required this.icon, this.onPressed, this.enabled, this.leading, this.trailing, this.alignment, this.size = ButtonSize.normal, this.focusNode, this.disableTransition = false, this.onHover, this.onFocus, this.enableFeedback, this.onTapDown, this.onTapUp, this.onTapCancel, this.onSecondaryTapDown, this.onSecondaryTapUp, this.onSecondaryTapCancel, this.onTertiaryTapDown, this.onTertiaryTapUp, this.onTertiaryTapCancel, this.onLongPressStart, this.onLongPressUp, this.onLongPressMoveUpdate, this.onLongPressEnd, this.onSecondaryLongPress, this.onTertiaryLongPress, this.variance = ButtonVariance.ghost, this.density = ButtonDensity.icon, this.shape = ButtonShape.rectangle});
  /// Creates an icon button with link styling.
  const IconButton.link({super.key, required this.icon, this.onPressed, this.enabled, this.leading, this.trailing, this.alignment, this.size = ButtonSize.normal, this.focusNode, this.disableTransition = false, this.onHover, this.onFocus, this.enableFeedback, this.onTapDown, this.onTapUp, this.onTapCancel, this.onSecondaryTapDown, this.onSecondaryTapUp, this.onSecondaryTapCancel, this.onTertiaryTapDown, this.onTertiaryTapUp, this.onTertiaryTapCancel, this.onLongPressStart, this.onLongPressUp, this.onLongPressMoveUpdate, this.onLongPressEnd, this.onSecondaryLongPress, this.onTertiaryLongPress, this.variance = ButtonVariance.link, this.density = ButtonDensity.icon, this.shape = ButtonShape.rectangle});
  /// Creates an icon button with text styling.
  const IconButton.text({super.key, required this.icon, this.onPressed, this.enabled, this.leading, this.trailing, this.alignment, this.size = ButtonSize.normal, this.focusNode, this.disableTransition = false, this.onHover, this.onFocus, this.enableFeedback, this.onTapDown, this.onTapUp, this.onTapCancel, this.onSecondaryTapDown, this.onSecondaryTapUp, this.onSecondaryTapCancel, this.onTertiaryTapDown, this.onTertiaryTapUp, this.onTertiaryTapCancel, this.onLongPressStart, this.onLongPressUp, this.onLongPressMoveUpdate, this.onLongPressEnd, this.onSecondaryLongPress, this.onTertiaryLongPress, this.variance = ButtonVariance.text, this.density = ButtonDensity.icon, this.shape = ButtonShape.rectangle});
  /// Creates an icon button with destructive styling.
  const IconButton.destructive({super.key, required this.icon, this.onPressed, this.enabled, this.leading, this.trailing, this.alignment, this.size = ButtonSize.normal, this.focusNode, this.disableTransition = false, this.onHover, this.onFocus, this.enableFeedback, this.onTapDown, this.onTapUp, this.onTapCancel, this.onSecondaryTapDown, this.onSecondaryTapUp, this.onSecondaryTapCancel, this.onTertiaryTapDown, this.onTertiaryTapUp, this.onTertiaryTapCancel, this.onLongPressStart, this.onLongPressUp, this.onLongPressMoveUpdate, this.onLongPressEnd, this.onSecondaryLongPress, this.onTertiaryLongPress, this.variance = ButtonVariance.destructive, this.density = ButtonDensity.icon, this.shape = ButtonShape.rectangle});
  Widget build(BuildContext context);
}
```
