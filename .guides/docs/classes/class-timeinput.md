---
title: "Class: TimeInput"
description: "Reactive time input field with formatted text editing and validation."
---

```dart
/// Reactive time input field with formatted text editing and validation.
///
/// A high-level time input widget that provides structured time entry through
/// formatted text fields. Supports hours, minutes, and optional seconds with
/// automatic state management through the controlled component pattern.
///
/// ## Features
///
/// - **Structured time entry**: Separate fields for hours, minutes, and seconds
/// - **Format validation**: Automatic validation and formatting of time components
/// - **Flexible display**: Optional seconds display and customizable separators
/// - **Form integration**: Automatic validation and form field registration
/// - **Keyboard navigation**: Tab navigation between time components
/// - **Accessibility**: Full screen reader support and keyboard input
///
/// ## Usage Patterns
///
/// **Controller-based (recommended for complex state):**
/// ```dart
/// final controller = ComponentController<TimeOfDay?>(TimeOfDay.now());
///
/// TimeInput(
///   controller: controller,
///   showSeconds: true,
///   placeholder: Text('Enter time'),
/// )
/// ```
///
/// **Callback-based (simple state management):**
/// ```dart
/// TimeOfDay? selectedTime;
///
/// TimeInput(
///   initialValue: selectedTime,
///   onChanged: (time) => setState(() => selectedTime = time),
///   showSeconds: false,
///   separator: InputPart.text(':'),
/// )
/// ```
class TimeInput extends StatefulWidget with ControlledComponent<TimeOfDay?> {
  final TimeOfDay? initialValue;
  final ValueChanged<TimeOfDay?>? onChanged;
  final bool enabled;
  final ComponentController<TimeOfDay?>? controller;
  /// Placeholder widget shown when no time is selected.
  final Widget? placeholder;
  /// Whether to show seconds input field.
  final bool showSeconds;
  /// Separator widget between time parts.
  final InputPart? separator;
  /// Custom placeholders for individual time parts.
  final Map<TimePart, Widget>? placeholders;
  /// Creates a [TimeInput].
  ///
  /// Either [controller] or [onChanged] should be provided for interactivity.
  /// The widget supports both controller-based and callback-based state management
  /// patterns with structured time component entry.
  ///
  /// Parameters:
  /// - [controller] (`ComponentController<TimeOfDay?>?`, optional): external state controller
  /// - [initialValue] (TimeOfDay?, optional): starting time when no controller
  /// - [onChanged] (`ValueChanged<TimeOfDay?>?`, optional): time change callback
  /// - [enabled] (bool, default: true): whether input is interactive
  /// - [placeholder] (Widget?, optional): widget shown when no time selected
  /// - [showSeconds] (bool, default: false): whether to include seconds input
  /// - [separator] (InputPart?, optional): separator between time components
  /// - [placeholders] (`Map<TimePart, Widget>?`, optional): placeholders for time parts
  ///
  /// Example:
  /// ```dart
  /// TimeInput(
  ///   controller: controller,
  ///   showSeconds: true,
  ///   separator: InputPart.text(':'),
  ///   placeholders: {
  ///     TimePart.hour: Text('HH'),
  ///     TimePart.minute: Text('MM'),
  ///     TimePart.second: Text('SS'),
  ///   },
  /// )
  /// ```
  const TimeInput({super.key, this.controller, this.initialValue, this.onChanged, this.enabled = true, this.placeholder, this.showSeconds = false, this.separator, this.placeholders});
  State<TimeInput> createState();
}
```
