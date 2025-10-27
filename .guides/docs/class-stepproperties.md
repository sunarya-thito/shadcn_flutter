---
title: "Class: StepProperties"
description: "Contains properties and state information for stepper rendering."
---

```dart
/// Contains properties and state information for stepper rendering.
///
/// Used internally by [StepVariant] implementations to build the
/// appropriate stepper layout. Provides access to step data, current
/// state, sizing configuration, and layout direction.
///
/// Also includes utility methods like [hasFailure] to check for failed
/// steps and array-style access to individual steps.
class StepProperties {
  /// Size configuration for step indicators.
  final StepSize size;
  /// List of steps in the stepper.
  final List<Step> steps;
  /// Listenable state containing current step and step states.
  final ValueListenable<StepperValue> state;
  /// Layout direction for the stepper.
  final Axis direction;
  /// Creates [StepProperties].
  const StepProperties({required this.size, required this.steps, required this.state, required this.direction});
  /// Safely accesses a step by index, returning null if out of bounds.
  Step? operator [](int index);
  /// Returns true if any step has a failed state.
  bool get hasFailure;
  bool operator ==(Object other);
  int get hashCode;
}
```
