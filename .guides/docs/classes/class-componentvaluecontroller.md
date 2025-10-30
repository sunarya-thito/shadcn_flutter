---
title: "Class: ComponentValueController"
description: "A concrete implementation of [ComponentController] that manages a single value."
---

```dart
/// A concrete implementation of [ComponentController] that manages a single value.
///
/// This controller provides a simple way to programmatically control any
/// component that accepts a [ComponentController]. It extends [ValueNotifier]
/// to provide change notification capabilities.
///
/// The controller maintains the current value and notifies listeners when
/// the value changes through the inherited [ValueNotifier.value] setter.
///
/// Example:
/// ```dart
/// final controller = ComponentValueController<String>('initial value');
///
/// // Listen to changes
/// controller.addListener(() {
///   print('Value changed to: ${controller.value}');
/// });
///
/// // Update the value
/// controller.value = 'new value';
/// ```
class ComponentValueController<T> extends ValueNotifier<T> implements ComponentController<T> {
  /// Creates a [ComponentValueController] with the given initial [value].
  ///
  /// The [value] parameter sets the initial state of the controller.
  /// Listeners will be notified whenever this value changes.
  ComponentValueController(super.value);
}
```
