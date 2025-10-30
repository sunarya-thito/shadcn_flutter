---
title: "Class: StepperController"
description: "Controller for managing stepper state and navigation."
---

```dart
/// Controller for managing stepper state and navigation.
///
/// Extends [ValueNotifier] to provide reactive state updates when
/// the current step changes or step states are modified. Includes
/// methods for navigation (next/previous), direct step jumping,
/// and setting individual step states.
///
/// The controller should be disposed when no longer needed to prevent
/// memory leaks.
///
/// Example:
/// ```dart
/// final controller = StepperController(currentStep: 0);
///
/// // Navigate to next step
/// controller.nextStep();
///
/// // Mark step as failed
/// controller.setStatus(1, StepState.failed);
///
/// // Jump to specific step
/// controller.jumpToStep(3);
///
/// // Don't forget to dispose
/// controller.dispose();
/// ```
class StepperController extends ValueNotifier<StepperValue> {
  /// Creates a [StepperController].
  ///
  /// Parameters:
  /// - [stepStates] (`Map<int, StepState>?`): initial step states (default: empty)
  /// - [currentStep] (int?): initial active step index (default: 0)
  ///
  /// Example:
  /// ```dart
  /// final controller = StepperController(
  ///   currentStep: 1,
  ///   stepStates: {0: StepState.failed},
  /// );
  /// ```
  StepperController({Map<int, StepState>? stepStates, int? currentStep});
  /// Advances to the next step.
  ///
  /// Increments the current step index by 1. Does not validate
  /// if the next step exists - callers should check bounds.
  ///
  /// Example:
  /// ```dart
  /// if (controller.value.currentStep < steps.length - 1) {
  ///   controller.nextStep();
  /// }
  /// ```
  void nextStep();
  /// Returns to the previous step.
  ///
  /// Decrements the current step index by 1. Does not validate
  /// if the previous step exists - callers should check bounds.
  ///
  /// Example:
  /// ```dart
  /// if (controller.value.currentStep > 0) {
  ///   controller.previousStep();
  /// }
  /// ```
  void previousStep();
  /// Sets or clears the state of a specific step.
  ///
  /// Parameters:
  /// - [step] (int): zero-based step index to modify
  /// - [state] (StepState?): new state, or null to clear
  ///
  /// Example:
  /// ```dart
  /// // Mark step as failed
  /// controller.setStatus(2, StepState.failed);
  ///
  /// // Clear step state
  /// controller.setStatus(2, null);
  /// ```
  void setStatus(int step, StepState? state);
  /// Jumps directly to the specified step.
  ///
  /// Parameters:
  /// - [step] (int): zero-based step index to navigate to
  ///
  /// Example:
  /// ```dart
  /// // Jump to final step
  /// controller.jumpToStep(steps.length - 1);
  /// ```
  void jumpToStep(int step);
}
```
