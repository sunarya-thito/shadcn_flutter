---
title: "Class: InputFeatureVisibility"
description: "Abstract base class for controlling input feature visibility."
---

```dart
/// Abstract base class for controlling input feature visibility.
///
/// Defines when UI elements like clear buttons, password toggles, or other
/// input features should be visible based on text field state. Supports
/// logical operations (AND, OR, NOT) to combine multiple visibility conditions.
///
/// Example:
/// ```dart
/// // Show clear button when text is not empty and field is focused
/// final visibility = InputFeatureVisibility.textNotEmpty &
///                   InputFeatureVisibility.focused;
/// ```
abstract class InputFeatureVisibility {
  /// Creates a visibility condition that is true when all [features] are true.
  factory InputFeatureVisibility.and(Iterable<InputFeatureVisibility> features);
  /// Creates a visibility condition that is true when any [features] is true.
  factory InputFeatureVisibility.or(Iterable<InputFeatureVisibility> features);
  /// Creates a visibility condition that inverts the given [feature].
  factory InputFeatureVisibility.not(InputFeatureVisibility feature);
  /// Visibility condition: text field is not empty.
  static const InputFeatureVisibility textNotEmpty = _TextNotEmptyInputFeatureVisibility();
  /// Visibility condition: text field is empty.
  static const InputFeatureVisibility textEmpty = _TextEmptyInputFeatureVisibility();
  /// Visibility condition: text field has focus.
  static const InputFeatureVisibility focused = _FocusedInputFeatureVisibility();
  /// Visibility condition: text field is being hovered.
  static const InputFeatureVisibility hovered = _HoveredInputFeatureVisibility();
  /// Visibility condition: never visible.
  static const InputFeatureVisibility never = _NeverVisibleInputFeatureVisibility();
  /// Visibility condition: always visible.
  static const InputFeatureVisibility always = _AlwaysVisibleInputFeatureVisibility();
  /// Visibility condition: text field has selected text.
  static const InputFeatureVisibility hasSelection = _HasSelectionInputFeatureVisibility();
  /// Creates an [InputFeatureVisibility].
  const InputFeatureVisibility();
  /// Gets the listenable dependencies for this visibility condition.
  ///
  /// Returns the state objects that should be monitored for changes.
  Iterable<Listenable> getDependencies(TextFieldState state);
  /// Checks if the feature can be shown in the current state.
  ///
  /// Returns `true` if all visibility conditions are met.
  bool canShow(TextFieldState state);
  /// Combines this visibility with [other] using logical AND.
  InputFeatureVisibility and(InputFeatureVisibility other);
  /// Operator form of [and]. Combines conditions with logical AND.
  InputFeatureVisibility operator &(InputFeatureVisibility other);
  /// Combines this visibility with [other] using logical OR.
  InputFeatureVisibility or(InputFeatureVisibility other);
  /// Operator form of [or]. Combines conditions with logical OR.
  InputFeatureVisibility operator |(InputFeatureVisibility other);
  /// Inverts this visibility condition using logical NOT.
  InputFeatureVisibility operator ~();
}
```
