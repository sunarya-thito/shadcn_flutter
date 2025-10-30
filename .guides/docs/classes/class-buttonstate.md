---
title: "Class: ButtonState"
description: "State class for [Button] widgets managing interactive state and rendering."
---

```dart
/// State class for [Button] widgets managing interactive state and rendering.
///
/// [ButtonState] handles the button's lifecycle, manages the [WidgetStatesController]
/// for tracking interactive states (pressed, hovered, focused, disabled), and
/// coordinates with the button's style system to apply appropriate visual changes
/// based on the current state.
///
/// This class is generic, allowing it to manage state for various button types
/// (primary, secondary, outline, etc.) through the type parameter [T].
///
/// The state class automatically:
/// - Creates or uses a provided [WidgetStatesController]
/// - Updates the disabled state based on [onPressed] availability
/// - Manages focus and hover interactions
/// - Applies style transitions and animations
class ButtonState<T extends Button> extends State<T> {
  void initState();
  void didChangeDependencies();
  void didUpdateWidget(T oldWidget);
  Widget build(BuildContext context);
}
```
