---
title: "Class: CheckboxController"
description: "Reactive controller for managing checkbox state with convenient methods."
---

```dart
/// Reactive controller for managing checkbox state with convenient methods.
///
/// Extends [ValueNotifier] to provide state management for checkbox widgets
/// with built-in methods for common state transitions. Supports all three
/// checkbox states: checked, unchecked, and indeterminate.
///
/// The controller can be used with [ControlledCheckbox] for reactive state
/// management or manually to coordinate checkbox behavior across widgets.
///
/// Example:
/// ```dart
/// final controller = CheckboxController(CheckboxState.unchecked);
///
/// // React to changes
/// controller.addListener(() {
///   print('Checkbox is now: ${controller.value}');
/// });
///
/// // Programmatic control
/// controller.toggle(); // unchecked -> checked
/// controller.indeterminate(); // -> indeterminate
/// ```
class CheckboxController extends ValueNotifier<CheckboxState> with ComponentController<CheckboxState> {
  /// Creates a [CheckboxController] with the specified initial [value].
  ///
  /// The controller will notify listeners whenever the checkbox state changes
  /// through any of the provided methods or direct value assignment.
  CheckboxController(super.value);
  /// Sets the checkbox state to checked.
  ///
  /// Notifies listeners of the state change. Equivalent to setting
  /// `value = CheckboxState.checked`.
  void check();
  /// Sets the checkbox state to unchecked.
  ///
  /// Notifies listeners of the state change. Equivalent to setting
  /// `value = CheckboxState.unchecked`.
  void uncheck();
  /// Sets the checkbox state to indeterminate.
  ///
  /// Notifies listeners of the state change. Used for tri-state checkboxes
  /// to indicate a partially selected or mixed state.
  void indeterminate();
  /// Toggles between checked and unchecked states.
  ///
  /// If currently checked, becomes unchecked. If currently unchecked or
  /// indeterminate, becomes checked. Does not cycle through indeterminate state.
  void toggle();
  /// Cycles through all three states in order: checked -> unchecked -> indeterminate.
  ///
  /// Provides complete tri-state cycling behavior. Use this instead of [toggle]
  /// when working with tri-state checkboxes that need to support indeterminate state.
  void toggleTristate();
  /// Returns true if the checkbox is currently checked.
  bool get isChecked;
  /// Returns true if the checkbox is currently unchecked.
  bool get isUnchecked;
  /// Returns true if the checkbox is currently in indeterminate state.
  bool get isIndeterminate;
}
```
