---
title: "Enum: CheckboxState"
description: "Represents the possible states of a checkbox widget."
---

```dart
/// Represents the possible states of a checkbox widget.
///
/// Supports the standard checked/unchecked binary states as well as an
/// indeterminate state commonly used to represent partial selection in
/// hierarchical or grouped checkbox scenarios.
///
/// The enum implements [Comparable] to provide consistent ordering:
/// checked < unchecked < indeterminate (based on declaration order).
enum CheckboxState {
  /// The checkbox is selected/checked state.
  ///
  /// Visually represented with a checkmark icon inside the checkbox square.
  /// Indicates the associated option or value is selected/enabled.
  checked,
  /// The checkbox is unselected/unchecked state.
  ///
  /// Visually represented as an empty checkbox square with border.
  /// Indicates the associated option or value is not selected/disabled.
  unchecked,
  /// The checkbox is in a partially selected/indeterminate state.
  ///
  /// Visually represented with a small square inside the checkbox.
  /// Typically used in hierarchical structures to indicate some but not
  /// all child items are selected, or when the state is unknown/mixed.
  indeterminate,
}
```
