---
title: "Class: IconButton"
description: "Reference for IconButton"
---

```dart
class IconButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback? onPressed;
  final bool? enabled;
  final Widget? leading;
  final Widget? trailing;
  final AlignmentGeometry? alignment;
  final ButtonSize size;
  final ButtonDensity density;
  final ButtonShape shape;
  final FocusNode? focusNode;
  final bool disableTransition;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocus;
  final bool? enableFeedback;
  final GestureTapDownCallback? onTapDown;
  final GestureTapUpCallback? onTapUp;
  final GestureTapCancelCallback? onTapCancel;
  final GestureTapDownCallback? onSecondaryTapDown;
  final GestureTapUpCallback? onSecondaryTapUp;
  final GestureTapCancelCallback? onSecondaryTapCancel;
  final GestureTapDownCallback? onTertiaryTapDown;
  final GestureTapUpCallback? onTertiaryTapUp;
  final GestureTapCancelCallback? onTertiaryTapCancel;
  final GestureLongPressStartCallback? onLongPressStart;
  final GestureLongPressUpCallback? onLongPressUp;
  final GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate;
  final GestureLongPressEndCallback? onLongPressEnd;
  final GestureLongPressUpCallback? onSecondaryLongPress;
  final GestureLongPressUpCallback? onTertiaryLongPress;
  final AbstractButtonStyle variance;
  const IconButton({super.key, required this.icon, required this.variance, this.onPressed, this.enabled, this.leading, this.trailing, this.alignment, this.size = ButtonSize.normal, this.density = ButtonDensity.icon, this.shape = ButtonShape.rectangle, this.focusNode, this.disableTransition = false, this.onHover, this.onFocus, this.enableFeedback, this.onTapDown, this.onTapUp, this.onTapCancel, this.onSecondaryTapDown, this.onSecondaryTapUp, this.onSecondaryTapCancel, this.onTertiaryTapDown, this.onTertiaryTapUp, this.onTertiaryTapCancel, this.onLongPressStart, this.onLongPressUp, this.onLongPressMoveUpdate, this.onLongPressEnd, this.onSecondaryLongPress, this.onTertiaryLongPress});
  const IconButton.primary({super.key, required this.icon, this.onPressed, this.enabled, this.leading, this.trailing, this.alignment, this.size = ButtonSize.normal, this.focusNode, this.disableTransition = false, this.onHover, this.onFocus, this.enableFeedback, this.onTapDown, this.onTapUp, this.onTapCancel, this.onSecondaryTapDown, this.onSecondaryTapUp, this.onSecondaryTapCancel, this.onTertiaryTapDown, this.onTertiaryTapUp, this.onTertiaryTapCancel, this.onLongPressStart, this.onLongPressUp, this.onLongPressMoveUpdate, this.onLongPressEnd, this.onSecondaryLongPress, this.onTertiaryLongPress, this.variance = ButtonVariance.primary, this.density = ButtonDensity.icon, this.shape = ButtonShape.rectangle});
  const IconButton.secondary({super.key, required this.icon, this.onPressed, this.enabled, this.leading, this.trailing, this.alignment, this.size = ButtonSize.normal, this.focusNode, this.disableTransition = false, this.onHover, this.onFocus, this.enableFeedback, this.onTapDown, this.onTapUp, this.onTapCancel, this.onSecondaryTapDown, this.onSecondaryTapUp, this.onSecondaryTapCancel, this.onTertiaryTapDown, this.onTertiaryTapUp, this.onTertiaryTapCancel, this.onLongPressStart, this.onLongPressUp, this.onLongPressMoveUpdate, this.onLongPressEnd, this.onSecondaryLongPress, this.onTertiaryLongPress, this.variance = ButtonVariance.secondary, this.density = ButtonDensity.icon, this.shape = ButtonShape.rectangle});
  const IconButton.outline({super.key, required this.icon, this.onPressed, this.enabled, this.leading, this.trailing, this.alignment, this.size = ButtonSize.normal, this.focusNode, this.disableTransition = false, this.onHover, this.onFocus, this.enableFeedback, this.onTapDown, this.onTapUp, this.onTapCancel, this.onSecondaryTapDown, this.onSecondaryTapUp, this.onSecondaryTapCancel, this.onTertiaryTapDown, this.onTertiaryTapUp, this.onTertiaryTapCancel, this.onLongPressStart, this.onLongPressUp, this.onLongPressMoveUpdate, this.onLongPressEnd, this.onSecondaryLongPress, this.onTertiaryLongPress, this.variance = ButtonVariance.outline, this.density = ButtonDensity.icon, this.shape = ButtonShape.rectangle});
  const IconButton.ghost({super.key, required this.icon, this.onPressed, this.enabled, this.leading, this.trailing, this.alignment, this.size = ButtonSize.normal, this.focusNode, this.disableTransition = false, this.onHover, this.onFocus, this.enableFeedback, this.onTapDown, this.onTapUp, this.onTapCancel, this.onSecondaryTapDown, this.onSecondaryTapUp, this.onSecondaryTapCancel, this.onTertiaryTapDown, this.onTertiaryTapUp, this.onTertiaryTapCancel, this.onLongPressStart, this.onLongPressUp, this.onLongPressMoveUpdate, this.onLongPressEnd, this.onSecondaryLongPress, this.onTertiaryLongPress, this.variance = ButtonVariance.ghost, this.density = ButtonDensity.icon, this.shape = ButtonShape.rectangle});
  const IconButton.link({super.key, required this.icon, this.onPressed, this.enabled, this.leading, this.trailing, this.alignment, this.size = ButtonSize.normal, this.focusNode, this.disableTransition = false, this.onHover, this.onFocus, this.enableFeedback, this.onTapDown, this.onTapUp, this.onTapCancel, this.onSecondaryTapDown, this.onSecondaryTapUp, this.onSecondaryTapCancel, this.onTertiaryTapDown, this.onTertiaryTapUp, this.onTertiaryTapCancel, this.onLongPressStart, this.onLongPressUp, this.onLongPressMoveUpdate, this.onLongPressEnd, this.onSecondaryLongPress, this.onTertiaryLongPress, this.variance = ButtonVariance.link, this.density = ButtonDensity.icon, this.shape = ButtonShape.rectangle});
  const IconButton.text({super.key, required this.icon, this.onPressed, this.enabled, this.leading, this.trailing, this.alignment, this.size = ButtonSize.normal, this.focusNode, this.disableTransition = false, this.onHover, this.onFocus, this.enableFeedback, this.onTapDown, this.onTapUp, this.onTapCancel, this.onSecondaryTapDown, this.onSecondaryTapUp, this.onSecondaryTapCancel, this.onTertiaryTapDown, this.onTertiaryTapUp, this.onTertiaryTapCancel, this.onLongPressStart, this.onLongPressUp, this.onLongPressMoveUpdate, this.onLongPressEnd, this.onSecondaryLongPress, this.onTertiaryLongPress, this.variance = ButtonVariance.text, this.density = ButtonDensity.icon, this.shape = ButtonShape.rectangle});
  const IconButton.destructive({super.key, required this.icon, this.onPressed, this.enabled, this.leading, this.trailing, this.alignment, this.size = ButtonSize.normal, this.focusNode, this.disableTransition = false, this.onHover, this.onFocus, this.enableFeedback, this.onTapDown, this.onTapUp, this.onTapCancel, this.onSecondaryTapDown, this.onSecondaryTapUp, this.onSecondaryTapCancel, this.onTertiaryTapDown, this.onTertiaryTapUp, this.onTertiaryTapCancel, this.onLongPressStart, this.onLongPressUp, this.onLongPressMoveUpdate, this.onLongPressEnd, this.onSecondaryLongPress, this.onTertiaryLongPress, this.variance = ButtonVariance.destructive, this.density = ButtonDensity.icon, this.shape = ButtonShape.rectangle});
  Widget build(BuildContext context);
}
```
