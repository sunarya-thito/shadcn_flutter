---
title: "Class: ControlledRadioGroup"
description: "Reactive radio button group with automatic state management and exclusivity."
---

```dart
/// Reactive radio button group with automatic state management and exclusivity.
///
/// A high-level radio group widget that provides automatic state management through
/// the controlled component pattern. Manages mutual exclusion between radio options
/// and supports both controller-based and callback-based state management.
///
/// ## Features
///
/// - **Mutual exclusion**: Automatically ensures only one radio button is selected
/// - **Flexible layout**: Works with any child layout (Column, Row, Wrap, etc.)
/// - **Keyboard navigation**: Full keyboard support with arrow keys and Space
/// - **Form integration**: Automatic validation and form field registration
/// - **State synchronization**: Keeps all radio buttons in sync automatically
///
/// ## Usage Patterns
///
/// **Controller-based (recommended for complex state):**
/// ```dart
/// final controller = RadioGroupController<String>('small');
///
/// ControlledRadioGroup<String>(
///   controller: controller,
///   child: Column(
///     children: [
///       Radio<String>(value: 'small', label: Text('Small')),
///       Radio<String>(value: 'medium', label: Text('Medium')),
///       Radio<String>(value: 'large', label: Text('Large')),
///     ],
///   ),
/// )
/// ```
///
/// **Callback-based (simple state management):**
/// ```dart
/// String? selectedSize;
///
/// ControlledRadioGroup<String>(
///   initialValue: selectedSize,
///   onChanged: (size) => setState(() => selectedSize = size),
///   child: Column(
///     children: [
///       Radio<String>(value: 'small', label: Text('Small')),
///       Radio<String>(value: 'medium', label: Text('Medium')),
///       Radio<String>(value: 'large', label: Text('Large')),
///     ],
///   ),
/// )
/// ```
class ControlledRadioGroup<T> extends StatelessWidget with ControlledComponent<T?> {
  final T? initialValue;
  final ValueChanged<T?>? onChanged;
  final bool enabled;
  final RadioGroupController<T?>? controller;
  /// Child widget containing the radio buttons.
  ///
  /// Usually a layout widget like Column, Row, or Wrap containing multiple
  /// [Radio] widgets. The radio group will manage the selection state
  /// of all descendant radio buttons automatically.
  final Widget child;
  /// Creates a [ControlledRadioGroup].
  ///
  /// Either [controller] or [onChanged] should be provided for interactivity.
  /// The widget supports both controller-based and callback-based state management
  /// patterns with automatic mutual exclusion between radio options.
  ///
  /// Parameters:
  /// - [controller] (`RadioGroupController<T>?`, optional): external state controller
  /// - [initialValue] (T?, optional): starting selection when no controller
  /// - [onChanged] (`ValueChanged<T?>?`, optional): selection change callback
  /// - [enabled] (bool, default: true): whether radio group is interactive
  /// - [child] (Widget, required): layout containing radio buttons
  ///
  /// Example:
  /// ```dart
  /// ControlledRadioGroup<String>(
  ///   controller: controller,
  ///   child: Column(
  ///     children: [
  ///       Radio<String>(value: 'option1', label: Text('Option 1')),
  ///       Radio<String>(value: 'option2', label: Text('Option 2')),
  ///     ],
  ///   ),
  /// )
  /// ```
  const ControlledRadioGroup({super.key, this.controller, this.initialValue, this.onChanged, this.enabled = true, required this.child});
  Widget build(BuildContext context);
}
```
