---
title: "Class: ControlledComponentData"
description: "Immutable data container for controlled component state."
---

```dart
/// Immutable data container for controlled component state.
///
/// This class encapsulates the three essential pieces of state that
/// controlled components need: the current value, a change callback,
/// and the enabled status. It provides a convenient way to pass
/// this state to widget builders.
///
/// The generic type [T] represents the type of value being managed.
class ControlledComponentData<T> {
  /// The current value of the component.
  ///
  /// This represents the component's current state and should be
  /// used by the UI to display the correct value to the user.
  final T value;
  /// Callback to invoke when the value should change.
  ///
  /// This callback should be called whenever the user interaction
  /// or programmatic action requires the value to be updated.
  /// The new value should be passed as the parameter.
  final ValueChanged<T> onChanged;
  /// Whether the component should accept user input.
  ///
  /// When false, the component should display in a disabled state
  /// and ignore user interactions.
  final bool enabled;
  /// Creates a [ControlledComponentData] with the specified state.
  ///
  /// All parameters are required as they represent the essential
  /// state needed for any controlled component to function properly.
  ///
  /// Parameters:
  /// - [value] (T, required): The current value to display
  /// - [onChanged] (`ValueChanged<T>`, required): Callback for value changes
  /// - [enabled] (bool, required): Whether the component accepts input
  const ControlledComponentData({required this.value, required this.onChanged, required this.enabled});
}
```
