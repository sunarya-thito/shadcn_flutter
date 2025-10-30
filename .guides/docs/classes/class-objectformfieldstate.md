---
title: "Class: ObjectFormFieldState"
description: "State class for [ObjectFormField] managing form value and user interactions."
---

```dart
/// State class for [ObjectFormField] managing form value and user interactions.
///
/// Handles value updates, popover/dialog display, and integrates with the
/// form validation system. This state also determines whether the field is
/// enabled based on the presence of an `onChanged` callback.
class ObjectFormFieldState<T> extends State<ObjectFormField<T>> with FormValueSupplier<T, ObjectFormField<T>> {
  void initState();
  /// Gets the current form value.
  ///
  /// Returns: The current value of type `T?`.
  T? get value;
  /// Sets a new form value and notifies listeners.
  ///
  /// Parameters:
  /// - [value] (`T?`, required): The new value to set.
  set value(T? value);
  void didReplaceFormValue(T value);
  void didUpdateWidget(covariant ObjectFormField<T> oldWidget);
  /// Whether this field is enabled.
  ///
  /// Returns true if explicitly enabled or if an `onChanged` callback exists.
  bool get enabled;
  void dispose();
  /// Prompts the user to select or edit a value via dialog or popover.
  ///
  /// Displays the appropriate UI based on the configured [PromptMode].
  ///
  /// Parameters:
  /// - [value] (`T?`, optional): An initial value to display in the prompt.
  ///
  /// Example:
  /// ```dart
  /// fieldState.prompt(initialValue);
  /// ```
  void prompt([T? value]);
  Widget build(BuildContext context);
}
```
