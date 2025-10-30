---
title: "Class: StepperValue"
description: "Immutable value representing the current state of a stepper."
---

```dart
/// Immutable value representing the current state of a stepper.
///
/// Contains the current active step index and a map of step states
/// for any steps that have special states (like failed). Used by
/// [StepperController] to track and notify about stepper state changes.
///
/// Example:
/// ```dart
/// final value = StepperValue(
///   currentStep: 2,
///   stepStates: {1: StepState.failed},
/// );
/// ```
class StepperValue {
  /// Map of step indices to their special states.
  final Map<int, StepState> stepStates;
  /// Index of the currently active step (0-based).
  final int currentStep;
  /// Creates a [StepperValue].
  ///
  /// Parameters:
  /// - [stepStates] (`Map<int, StepState>`, required): step states by index
  /// - [currentStep] (int, required): currently active step index
  StepperValue({required this.stepStates, required this.currentStep});
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
