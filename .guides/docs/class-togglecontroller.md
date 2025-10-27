---
title: "Class: ToggleController"
description: "A controller for managing toggle state in toggle buttons and switches."
---

```dart
/// A controller for managing toggle state in toggle buttons and switches.
///
/// [ToggleController] extends [ValueNotifier] to provide reactive state management
/// for boolean toggle values. It implements [ComponentController] to integrate
/// with the shadcn_flutter form system and provides convenient methods for
/// programmatic state changes.
///
/// The controller maintains a boolean value representing the toggle state and
/// notifies listeners when the state changes, making it suitable for use with
/// toggle buttons, switches, and other binary state controls.
///
/// Example:
/// ```dart
/// final toggleController = ToggleController(false);
///
/// // Listen to changes
/// toggleController.addListener(() {
///   print('Toggle state: ${toggleController.value}');
/// });
///
/// // Toggle the state programmatically
/// toggleController.toggle();
///
/// // Set specific value
/// toggleController.value = true;
/// ```
class ToggleController extends ValueNotifier<bool> with ComponentController<bool> {
  /// Creates a [ToggleController] with an initial toggle state.
  ///
  /// Parameters:
  /// - [value] (bool, default: false): The initial toggle state.
  ///
  /// Example:
  /// ```dart
  /// // Create controller starting in off state
  /// final controller = ToggleController();
  ///
  /// // Create controller starting in on state
  /// final controller = ToggleController(true);
  /// ```
  ToggleController([super.value = false]);
  /// Toggles the current boolean state.
  ///
  /// Changes `true` to `false` and `false` to `true`, then notifies all listeners
  /// of the change. This is equivalent to setting `value = !value` but provides
  /// a more semantic API for toggle operations.
  ///
  /// Example:
  /// ```dart
  /// final controller = ToggleController(false);
  /// controller.toggle(); // value is now true
  /// controller.toggle(); // value is now false
  /// ```
  void toggle();
}
```
