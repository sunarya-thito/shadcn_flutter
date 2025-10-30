---
title: "Class: SelectedButton"
description: "A button that changes style based on its selected state."
---

```dart
/// A button that changes style based on its selected state.
///
/// [SelectedButton] provides a stateful button that displays different styles
/// when selected versus unselected. It supports all standard button gestures
/// including tap, long press, and hover interactions.
///
/// ## Overview
///
/// Use [SelectedButton] when you need a button that visually indicates selection
/// state, such as in tab bars, segmented controls, or toggle groups. The button
/// automatically switches between [style] (unselected) and [selectedStyle] (selected)
/// based on the [value] parameter.
///
/// ## Example
///
/// ```dart
/// SelectedButton(
///   value: isSelected,
///   onChanged: (selected) => setState(() => isSelected = selected),
///   style: const ButtonStyle.ghost(),
///   selectedStyle: const ButtonStyle.secondary(),
///   child: Text('Option A'),
/// )
/// ```
class SelectedButton extends StatefulWidget {
  /// The current selection state of the button.
  final bool value;
  /// Called when the selection state changes.
  ///
  /// If `null`, the button is disabled.
  final ValueChanged<bool>? onChanged;
  /// The widget displayed inside the button.
  final Widget child;
  /// The button style when not selected.
  ///
  /// Defaults to ghost style.
  final AbstractButtonStyle style;
  /// The button style when selected.
  ///
  /// Defaults to secondary style.
  final AbstractButtonStyle selectedStyle;
  /// Whether the button is enabled.
  ///
  /// If `null`, enabled state is determined by whether [onChanged] is non-null.
  final bool? enabled;
  /// The alignment of the child within the button.
  final AlignmentGeometry? alignment;
  /// The margin alignment for the button.
  final AlignmentGeometry? marginAlignment;
  /// Whether to disable style transition animations.
  ///
  /// Defaults to `false`. When `true`, style changes are instant.
  final bool disableTransition;
  /// Called when the hover state changes.
  final ValueChanged<bool>? onHover;
  /// Called when the focus state changes.
  final ValueChanged<bool>? onFocus;
  /// Whether to enable haptic/audio feedback.
  final bool? enableFeedback;
  /// Called when a primary tap down event occurs.
  final GestureTapDownCallback? onTapDown;
  /// Called when a primary tap up event occurs.
  final GestureTapUpCallback? onTapUp;
  /// Called when a primary tap is cancelled.
  final GestureTapCancelCallback? onTapCancel;
  /// Called when a secondary tap down event occurs.
  final GestureTapDownCallback? onSecondaryTapDown;
  /// Called when a secondary tap up event occurs.
  final GestureTapUpCallback? onSecondaryTapUp;
  /// Called when a secondary tap is cancelled.
  final GestureTapCancelCallback? onSecondaryTapCancel;
  /// Called when a tertiary tap down event occurs.
  final GestureTapDownCallback? onTertiaryTapDown;
  /// Called when a tertiary tap up event occurs.
  final GestureTapUpCallback? onTertiaryTapUp;
  /// Called when a tertiary tap is cancelled.
  final GestureTapCancelCallback? onTertiaryTapCancel;
  /// Called when a long press starts.
  final GestureLongPressStartCallback? onLongPressStart;
  /// Called when a long press is released.
  final GestureLongPressUpCallback? onLongPressUp;
  /// Called when a long press moves.
  final GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate;
  /// Called when a long press ends.
  final GestureLongPressEndCallback? onLongPressEnd;
  /// Called when a secondary long press completes.
  final GestureLongPressUpCallback? onSecondaryLongPress;
  /// Called when a tertiary long press completes.
  final GestureLongPressUpCallback? onTertiaryLongPress;
  /// Whether to disable the hover effect.
  ///
  /// Defaults to `false`.
  final bool disableHoverEffect;
  /// Optional controller for programmatic state management.
  final WidgetStatesController? statesController;
  /// Called when the button is pressed (tapped).
  final VoidCallback? onPressed;
  /// Creates a [SelectedButton] widget.
  ///
  /// A button that toggles between selected and unselected states, applying
  /// different styles based on the current [value].
  ///
  /// Parameters:
  /// - [value] (required): The current selection state (`true` for selected).
  /// - [onChanged]: Callback invoked when the selection state changes. If `null`, the button is disabled.
  /// - [child] (required): The widget displayed inside the button.
  /// - [enabled]: Whether the button is enabled. Defaults to checking if [onChanged] is non-null.
  /// - [style]: Style applied when unselected. Defaults to [ButtonStyle.ghost].
  /// - [selectedStyle]: Style applied when selected. Defaults to [ButtonStyle.secondary].
  /// - [alignment]: Alignment of the child within the button.
  /// - [marginAlignment]: Margin alignment for the button.
  /// - [disableTransition]: If `true`, disables style transition animations. Defaults to `false`.
  /// - [onHover]: Called when the hover state changes.
  /// - [onFocus]: Called when the focus state changes.
  /// - [enableFeedback]: Whether to enable haptic/audio feedback.
  /// - [onTapDown], [onTapUp], [onTapCancel]: Primary tap gesture callbacks.
  /// - [onSecondaryTapDown], [onSecondaryTapUp], [onSecondaryTapCancel]: Secondary tap gesture callbacks.
  /// - [onTertiaryTapDown], [onTertiaryTapUp], [onTertiaryTapCancel]: Tertiary tap gesture callbacks.
  /// - [onLongPressStart], [onLongPressUp], [onLongPressMoveUpdate], [onLongPressEnd]: Long press gesture callbacks.
  /// - [onSecondaryLongPress], [onTertiaryLongPress]: Secondary and tertiary long press callbacks.
  /// - [disableHoverEffect]: If `true`, disables the hover effect. Defaults to `false`.
  /// - [statesController]: Optional controller for programmatic state management.
  /// - [onPressed]: Called when the button is tapped.
  ///
  /// Example:
  /// ```dart
  /// SelectedButton(
  ///   value: isSelected,
  ///   onChanged: (selected) => setState(() => isSelected = selected),
  ///   child: Text('Toggle Me'),
  /// )
  /// ```
  const SelectedButton({super.key, required this.value, this.onChanged, required this.child, this.enabled, this.style = const ButtonStyle.ghost(), this.selectedStyle = const ButtonStyle.secondary(), this.alignment, this.marginAlignment, this.disableTransition = false, this.onHover, this.onFocus, this.enableFeedback, this.onTapDown, this.onTapUp, this.onTapCancel, this.onSecondaryTapDown, this.onSecondaryTapUp, this.onSecondaryTapCancel, this.onTertiaryTapDown, this.onTertiaryTapUp, this.onTertiaryTapCancel, this.onLongPressStart, this.onLongPressUp, this.onLongPressMoveUpdate, this.onLongPressEnd, this.onSecondaryLongPress, this.onTertiaryLongPress, this.disableHoverEffect = false, this.statesController, this.onPressed});
  SelectedButtonState createState();
}
```
