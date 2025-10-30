---
title: "Class: ControlledComponentAdapter"
description: "A widget adapter that bridges controlled component logic with custom UI implementations."
---

```dart
/// A widget adapter that bridges controlled component logic with custom UI implementations.
///
/// This adapter provides a standardized way to implement controlled components
/// by handling the common logic for value management, controller integration,
/// and state synchronization. It implements the [ControlledComponent] mixin
/// and manages the lifecycle of value updates between controllers and UI.
///
/// The adapter supports both controlled mode (with a [controller]) and
/// uncontrolled mode (with an [initialValue]). When a controller is provided,
/// it becomes the source of truth for the component's value. When no controller
/// is provided, the component maintains its own internal state.
///
/// The generic type [T] represents the type of value this adapter manages.
///
/// Example:
/// ```dart
/// ControlledComponentAdapter<String>(
///   initialValue: 'Hello',
///   onChanged: (value) => print('Value changed: $value'),
///   builder: (context, data) {
///     return GestureDetector(
///       onTap: () => data.onChanged('${data.value}!'),
///       child: Text(data.value),
///     );
///   },
/// );
/// ```
class ControlledComponentAdapter<T> extends StatefulWidget with ControlledComponent<T> {
  final T? initialValue;
  final ValueChanged<T>? onChanged;
  final bool enabled;
  final ComponentController<T>? controller;
  /// A builder function that creates the widget UI using the provided state data.
  ///
  /// This function receives the current [BuildContext] and [ControlledComponentData]
  /// containing the current value, change callback, and enabled state. The builder
  /// should create a widget that displays the current value and calls the
  /// onChanged callback when user interaction occurs.
  final Widget Function(BuildContext context, ControlledComponentData<T> data) builder;
  /// Creates a [ControlledComponentAdapter].
  ///
  /// Either [controller] or [initialValue] must be provided to establish
  /// the component's initial state. The [builder] function is required
  /// and will be called to construct the UI with the current state.
  ///
  /// Parameters:
  /// - [builder] (required): Function that builds the UI using state data
  /// - [initialValue] (T?, optional): Initial value when no controller is used
  /// - [onChanged] (`ValueChanged<T>?`, optional): Callback for value changes
  /// - [controller] (`ComponentController<T>?`, optional): External controller for value management
  /// - [enabled] (bool, default: true): Whether the component accepts user input
  ///
  /// Throws [AssertionError] if neither controller nor initialValue is provided.
  ///
  /// Example:
  /// ```dart
  /// ControlledComponentAdapter<bool>(
  ///   initialValue: false,
  ///   enabled: true,
  ///   builder: (context, data) => Switch(
  ///     value: data.value,
  ///     onChanged: data.enabled ? data.onChanged : null,
  ///   ),
  /// );
  /// ```
  const ControlledComponentAdapter({super.key, required this.builder, this.initialValue, this.onChanged, this.controller, this.enabled = true});
  State<ControlledComponentAdapter<T>> createState();
}
```
