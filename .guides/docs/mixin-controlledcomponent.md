---
title: "Mixin: ControlledComponent"
description: "A mixin that provides a standardized interface for controlled components."
---

```dart
/// A mixin that provides a standardized interface for controlled components.
///
/// This mixin defines the contract that all controlled form components should
/// follow. It provides properties for external control through a controller,
/// initial value specification, change notifications, and enabled state management.
///
/// Components that use this mixin can be controlled either through a
/// [ComponentController] (for programmatic control) or through direct
/// property values (for declarative control).
///
/// The generic type [T] represents the type of value this component manages.
mixin ControlledComponent<T> on Widget {
  /// The controller for managing this component's value programmatically.
  ///
  /// When provided, the controller takes precedence over [initialValue]
  /// and manages the component's state externally. This is useful for
  /// form validation, programmatic value changes, and state persistence.
  ComponentController<T>? get controller;
  /// The initial value for this component when no controller is provided.
  ///
  /// This value is used only when [controller] is null. It sets the
  /// component's initial state and is ignored if a controller is present.
  T? get initialValue;
  /// Callback invoked when the component's value changes.
  ///
  /// This callback is called whenever the user interacts with the component
  /// or when the value is changed programmatically. The callback receives
  /// the new value as its parameter.
  ValueChanged<T>? get onChanged;
  /// Whether this component is enabled and accepts user input.
  ///
  /// When false, the component is displayed in a disabled state and
  /// does not respond to user interactions. The visual appearance
  /// typically changes to indicate the disabled state.
  bool get enabled;
}
```
