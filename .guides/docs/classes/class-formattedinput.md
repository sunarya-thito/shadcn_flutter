---
title: "Class: FormattedInput"
description: "A controlled input widget for structured data entry with formatting."
---

```dart
/// A controlled input widget for structured data entry with formatting.
///
/// This widget provides a sophisticated input system that combines static text
/// elements with editable fields in a single input interface. It's ideal for
/// formatted inputs like phone numbers, credit cards, dates, or any structured
/// data that requires specific formatting patterns.
///
/// The FormattedInput manages multiple editable segments, each with their own
/// validation, formatting, and input restrictions. It automatically handles
/// focus management between segments and provides a seamless user experience
/// with proper keyboard navigation.
///
/// Example:
/// ```dart
/// FormattedInput(
///   style: TextStyle(fontFamily: 'monospace'),
///   leading: Icon(Icons.phone),
///   initialValue: FormattedValue([
///     FormattedValuePart.static('('),
///     FormattedValuePart.editable('555', length: 3),
///     FormattedValuePart.static(') '),
///     FormattedValuePart.editable('123', length: 3),
///     FormattedValuePart.static('-'),
///     FormattedValuePart.editable('4567', length: 4),
///   ]),
/// );
/// ```
class FormattedInput extends StatefulWidget with ControlledComponent<FormattedValue> {
  final FormattedValue? initialValue;
  final ValueChanged<FormattedValue>? onChanged;
  final bool enabled;
  final FormattedInputController? controller;
  /// Text style applied to all input segments.
  ///
  /// This style affects both static text and editable input fields within
  /// the formatted input. Using a monospace font family is recommended
  /// for consistent character spacing across segments.
  final TextStyle? style;
  /// Widget displayed at the beginning of the input.
  ///
  /// Commonly used for icons or labels that provide context for the input
  /// content, such as a phone icon for phone number inputs.
  final Widget? leading;
  /// Widget displayed at the end of the input.
  ///
  /// Can be used for action buttons, status indicators, or additional
  /// context related to the input content.
  final Widget? trailing;
  /// Creates a [FormattedInput].
  ///
  /// The input structure is defined by the [initialValue] or [controller]
  /// value, which contains the mix of static text and editable segments.
  /// Each editable segment can have its own length restrictions and formatting.
  ///
  /// Parameters:
  /// - [initialValue] (FormattedValue?, optional): Initial structure and values
  /// - [onChanged] (`ValueChanged<FormattedValue>?`, optional): Callback for value changes
  /// - [style] (TextStyle?, optional): Text styling for all segments
  /// - [leading] (Widget?, optional): Widget displayed before the input
  /// - [trailing] (Widget?, optional): Widget displayed after the input
  /// - [enabled] (bool, default: true): Whether the input accepts user interaction
  /// - [controller] (FormattedInputController?, optional): External controller for programmatic control
  ///
  /// Example:
  /// ```dart
  /// FormattedInput(
  ///   initialValue: FormattedValue([
  ///     FormattedValuePart.static('$'),
  ///     FormattedValuePart.editable('0.00', length: 8),
  ///   ]),
  ///   leading: Icon(Icons.attach_money),
  ///   style: TextStyle(fontSize: 16),
  /// );
  /// ```
  const FormattedInput({super.key, this.initialValue, this.onChanged, this.style, this.leading, this.trailing, this.enabled = true, this.controller});
  State<FormattedInput> createState();
}
```
