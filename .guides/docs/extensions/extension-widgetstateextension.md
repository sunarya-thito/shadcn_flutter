---
title: "Extension: WidgetStateExtension"
description: "Extension on `Set<WidgetState>` providing convenient boolean getters for common states."
---

```dart
/// Extension on `Set<WidgetState>` providing convenient boolean getters for common states.
///
/// This extension simplifies checking for widget states by providing readable
/// property accessors instead of using `contains()` calls.
///
/// ## Example
///
/// ```dart
/// Set<WidgetState> states = {WidgetState.hovered, WidgetState.focused};
///
/// if (states.hovered) {
///   // Handle hover state
/// }
/// if (states.disabled) {
///   // Handle disabled state
/// }
/// ```
extension WidgetStateExtension on Set<WidgetState> {
  /// Whether the widget is in a disabled state.
  bool get disabled;
  /// Whether the widget is in an error state.
  bool get error;
  /// Whether the widget is in a selected state.
  bool get selected;
  /// Whether the widget is in a pressed state.
  bool get pressed;
  /// Whether the widget is in a hovered state.
  bool get hovered;
  /// Whether the widget is in a focused state.
  bool get focused;
}
```
