# Clickable

A highly configurable clickable widget with extensive gesture and state support.

## Usage

### Basic Example
```dart
Clickable(
  onPressed: () => print('Clicked!'),
  decoration: WidgetStateProperty.resolveWith((states) {
    if (states.contains(WidgetState.pressed)) {
      return BoxDecoration(color: Colors.blue.shade700);
    }
    return BoxDecoration(color: Colors.blue);
  }),
  child: Padding(
    padding: EdgeInsets.all(8),
    child: Text('Click Me'),
  ),
)
```



## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `child` | `Widget` | The child widget displayed within the clickable area. |
| `enabled` | `bool` | Whether the widget is enabled and can respond to interactions. |
| `onHover` | `ValueChanged<bool>?` | Called when hover state changes. |
| `onFocus` | `ValueChanged<bool>?` | Called when focus state changes. |
| `decoration` | `WidgetStateProperty<Decoration?>?` | State-aware decoration for the widget. |
| `mouseCursor` | `WidgetStateProperty<MouseCursor?>?` | State-aware mouse cursor style. |
| `padding` | `WidgetStateProperty<EdgeInsetsGeometry?>?` | State-aware padding around the child. |
| `textStyle` | `WidgetStateProperty<TextStyle?>?` | State-aware text style applied to text descendants. |
| `iconTheme` | `WidgetStateProperty<IconThemeData?>?` | State-aware icon theme applied to icon descendants. |
| `margin` | `WidgetStateProperty<EdgeInsetsGeometry?>?` | State-aware margin around the widget. |
| `transform` | `WidgetStateProperty<Matrix4?>?` | State-aware transformation matrix. |
| `onPressed` | `VoidCallback?` | Called when the widget is tapped (primary button). |
| `onDoubleTap` | `VoidCallback?` | Called when the widget is double-tapped. |
| `focusNode` | `FocusNode?` | Focus node for keyboard focus management. |
| `behavior` | `HitTestBehavior` | How to behave during hit testing. |
| `disableTransition` | `bool` | Whether to disable state transition animations. |
| `shortcuts` | `Map<LogicalKeySet, Intent>?` | Keyboard shortcuts to handle. |
| `actions` | `Map<Type, Action<Intent>>?` | Actions to handle for intents. |
| `focusOutline` | `bool` | Whether to show focus outline for accessibility. |
| `enableFeedback` | `bool` | Whether to enable haptic/audio feedback. |
| `onLongPress` | `VoidCallback?` | Called when long-pressed. |
| `onTapDown` | `GestureTapDownCallback?` | Called on primary tap down. |
| `onTapUp` | `GestureTapUpCallback?` | Called on primary tap up. |
| `onTapCancel` | `GestureTapCancelCallback?` | Called when primary tap is cancelled. |
| `onSecondaryTapDown` | `GestureTapDownCallback?` | Called on secondary (right-click) tap down. |
| `onSecondaryTapUp` | `GestureTapUpCallback?` | Called on secondary tap up. |
| `onSecondaryTapCancel` | `GestureTapCancelCallback?` | Called when secondary tap is cancelled. |
| `onTertiaryTapDown` | `GestureTapDownCallback?` | Called on tertiary (middle-click) tap down. |
| `onTertiaryTapUp` | `GestureTapUpCallback?` | Called on tertiary tap up. |
| `onTertiaryTapCancel` | `GestureTapCancelCallback?` | Called when tertiary tap is cancelled. |
| `onLongPressStart` | `GestureLongPressStartCallback?` | Called when long press starts. |
| `onLongPressUp` | `GestureLongPressUpCallback?` | Called when long press is released. |
| `onLongPressMoveUpdate` | `GestureLongPressMoveUpdateCallback?` | Called when long press moves. |
| `onLongPressEnd` | `GestureLongPressEndCallback?` | Called when long press ends. |
| `onSecondaryLongPress` | `GestureLongPressUpCallback?` | Called on secondary long press completion. |
| `onTertiaryLongPress` | `GestureLongPressUpCallback?` | Called on tertiary long press completion. |
| `disableHoverEffect` | `bool` | Whether to disable hover visual effects. |
| `statesController` | `WidgetStatesController?` | Optional controller for programmatic state management. |
| `marginAlignment` | `AlignmentGeometry?` | Alignment for applying margin. |
| `disableFocusOutline` | `bool` | Whether to disable the focus outline. |
