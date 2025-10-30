---
title: "Class: SwitchController"
description: "Controller for managing switch state."
---

```dart
/// Controller for managing switch state.
///
/// Extends [ValueNotifier] with [bool] values to provide state management
/// for switch widgets. Includes a convenience [toggle] method for flipping
/// the switch state.
///
/// Example:
/// ```dart
/// final controller = SwitchController(true);
/// controller.toggle(); // Now false
/// ```
class SwitchController extends ValueNotifier<bool> with ComponentController<bool> {
  /// Creates a [SwitchController].
  ///
  /// Parameters:
  /// - [value] (`bool`, default: `false`): Initial switch state.
  SwitchController([super.value = false]);
  /// Toggles the switch state between `true` and `false`.
  void toggle();
}
```
