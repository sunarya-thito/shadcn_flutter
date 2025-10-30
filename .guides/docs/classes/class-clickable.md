---
title: "Class: Clickable"
description: "A highly configurable clickable widget with extensive gesture and state support."
---

```dart
/// A highly configurable clickable widget with extensive gesture and state support.
///
/// [Clickable] provides a comprehensive foundation for interactive widgets, handling
/// various input gestures (tap, double-tap, long-press, etc.), visual states, and
/// accessibility features. It manages decoration, styling, and transitions based on
/// widget states like hover, focus, and press.
///
/// ## Overview
///
/// Use [Clickable] when building custom interactive components that need:
/// - Fine-grained gesture control (primary, secondary, tertiary taps)
/// - State-aware styling (decoration, text style, mouse cursor, etc.)
/// - Focus management and keyboard shortcuts
/// - Smooth transitions between states
/// - Accessibility features like focus outlines
///
/// ## Example
///
/// ```dart
/// Clickable(
///   onPressed: () => print('Clicked!'),
///   decoration: WidgetStateProperty.resolveWith((states) {
///     if (states.contains(WidgetState.pressed)) {
///       return BoxDecoration(color: Colors.blue.shade700);
///     }
///     return BoxDecoration(color: Colors.blue);
///   }),
///   child: Padding(
///     padding: EdgeInsets.all(8),
///     child: Text('Click Me'),
///   ),
/// )
/// ```
class Clickable extends StatefulWidget {
  /// The child widget displayed within the clickable area.
  final Widget child;
  /// Whether the widget is enabled and can respond to interactions.
  final bool enabled;
  /// Called when hover state changes.
  final ValueChanged<bool>? onHover;
  /// Called when focus state changes.
  final ValueChanged<bool>? onFocus;
  /// State-aware decoration for the widget.
  final WidgetStateProperty<Decoration?>? decoration;
  /// State-aware mouse cursor style.
  final WidgetStateProperty<MouseCursor?>? mouseCursor;
  /// State-aware padding around the child.
  final WidgetStateProperty<EdgeInsetsGeometry?>? padding;
  /// State-aware text style applied to text descendants.
  final WidgetStateProperty<TextStyle?>? textStyle;
  /// State-aware icon theme applied to icon descendants.
  final WidgetStateProperty<IconThemeData?>? iconTheme;
  /// State-aware margin around the widget.
  final WidgetStateProperty<EdgeInsetsGeometry?>? margin;
  /// State-aware transformation matrix.
  final WidgetStateProperty<Matrix4?>? transform;
  /// Called when the widget is tapped (primary button).
  final VoidCallback? onPressed;
  /// Called when the widget is double-tapped.
  final VoidCallback? onDoubleTap;
  /// Focus node for keyboard focus management.
  final FocusNode? focusNode;
  /// How to behave during hit testing.
  final HitTestBehavior behavior;
  /// Whether to disable state transition animations.
  final bool disableTransition;
  /// Keyboard shortcuts to handle.
  final Map<LogicalKeySet, Intent>? shortcuts;
  /// Actions to handle for intents.
  final Map<Type, Action<Intent>>? actions;
  /// Whether to show focus outline for accessibility.
  final bool focusOutline;
  /// Whether to enable haptic/audio feedback.
  final bool enableFeedback;
  /// Called when long-pressed.
  final VoidCallback? onLongPress;
  /// Called on primary tap down.
  final GestureTapDownCallback? onTapDown;
  /// Called on primary tap up.
  final GestureTapUpCallback? onTapUp;
  /// Called when primary tap is cancelled.
  final GestureTapCancelCallback? onTapCancel;
  /// Called on secondary (right-click) tap down.
  final GestureTapDownCallback? onSecondaryTapDown;
  /// Called on secondary tap up.
  final GestureTapUpCallback? onSecondaryTapUp;
  /// Called when secondary tap is cancelled.
  final GestureTapCancelCallback? onSecondaryTapCancel;
  /// Called on tertiary (middle-click) tap down.
  final GestureTapDownCallback? onTertiaryTapDown;
  /// Called on tertiary tap up.
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
  /// Called on secondary long press completion.
  final GestureLongPressUpCallback? onSecondaryLongPress;
  /// Called on tertiary long press completion.
  final GestureLongPressUpCallback? onTertiaryLongPress;
  /// Whether to disable hover visual effects.
  final bool disableHoverEffect;
  /// Optional controller for programmatic state management.
  final WidgetStatesController? statesController;
  /// Alignment for applying margin.
  final AlignmentGeometry? marginAlignment;
  /// Whether to disable the focus outline.
  final bool disableFocusOutline;
  /// Creates a [Clickable] widget.
  ///
  /// A clickable area with state-dependent styling and comprehensive gesture support.
  ///
  /// Parameters:
  /// - [child] (required): The widget to display and make clickable
  /// - [enabled]: Whether the widget is enabled. Defaults to `true`
  /// - [onPressed]: Primary tap callback. If `null`, widget is disabled
  /// - [decoration], [mouseCursor], [padding], [textStyle], [iconTheme], [margin], [transform]:
  ///   State-dependent property functions for styling
  /// - [focusNode]: Optional focus node for keyboard focus management
  /// - [behavior]: Hit test behavior. Defaults to [HitTestBehavior.translucent]
  /// - [onHover], [onFocus]: State change callbacks
  /// - [disableTransition]: If `true`, disables animation transitions. Defaults to `false`
  /// - [disableHoverEffect]: If `true`, disables hover visual effects. Defaults to `false`
  /// - [onDoubleTap]: Double tap callback
  /// - [shortcuts], [actions]: Keyboard shortcuts and actions
  /// - [focusOutline]: Whether to show focus outline. Defaults to `true`
  /// - [enableFeedback]: Whether to enable haptic/audio feedback. Defaults to `true`
  /// - [onTapDown], [onTapUp], [onTapCancel]: Primary tap gesture callbacks
  /// - [onSecondaryTapDown], [onSecondaryTapUp], [onSecondaryTapCancel]: Secondary tap callbacks
  /// - [onTertiaryTapDown], [onTertiaryTapUp], [onTertiaryTapCancel]: Tertiary tap callbacks
  /// - [onLongPress], [onLongPressStart], [onLongPressUp], [onLongPressMoveUpdate], [onLongPressEnd]:
  ///   Long press gesture callbacks
  /// - [onSecondaryLongPress], [onTertiaryLongPress]: Secondary and tertiary long press callbacks
  /// - [statesController]: Optional controller for programmatic state management
  /// - [marginAlignment]: Alignment for applying margin
  /// - [disableFocusOutline]: Whether to disable the focus outline. Defaults to `false`
  const Clickable({super.key, required this.child, this.statesController, this.enabled = true, this.decoration, this.mouseCursor, this.padding, this.textStyle, this.iconTheme, this.onPressed, this.focusNode, this.behavior = HitTestBehavior.translucent, this.onHover, this.onFocus, this.disableTransition = false, this.disableHoverEffect = false, this.margin, this.onDoubleTap, this.shortcuts, this.actions, this.focusOutline = true, this.enableFeedback = true, this.transform, this.onLongPress, this.onTapDown, this.onTapUp, this.onTapCancel, this.onSecondaryTapDown, this.onSecondaryTapUp, this.onSecondaryTapCancel, this.onTertiaryTapDown, this.onTertiaryTapUp, this.onTertiaryTapCancel, this.onLongPressStart, this.onLongPressUp, this.onLongPressMoveUpdate, this.onLongPressEnd, this.onSecondaryLongPress, this.onTertiaryLongPress, this.marginAlignment, this.disableFocusOutline = false});
  State<Clickable> createState();
}
```
