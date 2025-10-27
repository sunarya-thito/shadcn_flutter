---
title: "Class: Clickable"
description: "Reference for Clickable"
---

```dart
class Clickable extends StatefulWidget {
  final Widget child;
  final bool enabled;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocus;
  final WidgetStateProperty<Decoration?>? decoration;
  final WidgetStateProperty<MouseCursor?>? mouseCursor;
  final WidgetStateProperty<EdgeInsetsGeometry?>? padding;
  final WidgetStateProperty<TextStyle?>? textStyle;
  final WidgetStateProperty<IconThemeData?>? iconTheme;
  final WidgetStateProperty<EdgeInsetsGeometry?>? margin;
  final WidgetStateProperty<Matrix4?>? transform;
  final VoidCallback? onPressed;
  final VoidCallback? onDoubleTap;
  final FocusNode? focusNode;
  final HitTestBehavior behavior;
  final bool disableTransition;
  final Map<LogicalKeySet, Intent>? shortcuts;
  final Map<Type, Action<Intent>>? actions;
  final bool focusOutline;
  final bool enableFeedback;
  final VoidCallback? onLongPress;
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
  final bool disableHoverEffect;
  final WidgetStatesController? statesController;
  final AlignmentGeometry? marginAlignment;
  final bool disableFocusOutline;
  const Clickable({super.key, required this.child, this.statesController, this.enabled = true, this.decoration, this.mouseCursor, this.padding, this.textStyle, this.iconTheme, this.onPressed, this.focusNode, this.behavior = HitTestBehavior.translucent, this.onHover, this.onFocus, this.disableTransition = false, this.disableHoverEffect = false, this.margin, this.onDoubleTap, this.shortcuts, this.actions, this.focusOutline = true, this.enableFeedback = true, this.transform, this.onLongPress, this.onTapDown, this.onTapUp, this.onTapCancel, this.onSecondaryTapDown, this.onSecondaryTapUp, this.onSecondaryTapCancel, this.onTertiaryTapDown, this.onTertiaryTapUp, this.onTertiaryTapCancel, this.onLongPressStart, this.onLongPressUp, this.onLongPressMoveUpdate, this.onLongPressEnd, this.onSecondaryLongPress, this.onTertiaryLongPress, this.marginAlignment, this.disableFocusOutline = false});
  State<Clickable> createState();
}
```
