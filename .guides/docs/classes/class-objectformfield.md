---
title: "Class: ObjectFormField"
description: "A form field widget for complex object values."
---

```dart
/// A form field widget for complex object values.
///
/// [ObjectFormField] provides a button-like trigger that opens an editor
/// (in a dialog or popover) for selecting/editing complex values. The field
/// displays the selected value using a custom builder.
///
/// Useful for date pickers, color pickers, file selectors, and other
/// complex input scenarios where a simple text field isn't sufficient.
///
/// Example:
/// ```dart
/// ObjectFormField<DateTime>(
///   value: selectedDate,
///   placeholder: Text('Select date'),
///   builder: (context, date) => Text(formatDate(date)),
///   editorBuilder: (context, handler) => CalendarWidget(),
///   mode: PromptMode.dialog,
/// )
/// ```
class ObjectFormField<T> extends StatefulWidget {
  /// The current value of the field.
  final T? value;
  /// Called when the value changes.
  final ValueChanged<T?>? onChanged;
  /// Widget displayed when no value is selected.
  final Widget placeholder;
  /// Builds the display for the selected value.
  final Widget Function(BuildContext context, T value) builder;
  /// Optional leading widget (e.g., icon).
  final Widget? leading;
  /// Optional trailing widget (e.g., dropdown arrow).
  final Widget? trailing;
  /// How the editor is presented (dialog or popover).
  final PromptMode mode;
  /// Builds the editor widget.
  final Widget Function(BuildContext context, ObjectFormHandler<T> handler) editorBuilder;
  /// Popover alignment relative to the trigger.
  final AlignmentGeometry? popoverAlignment;
  /// Anchor alignment for popover positioning.
  final AlignmentGeometry? popoverAnchorAlignment;
  /// Padding inside the popover.
  final EdgeInsetsGeometry? popoverPadding;
  /// Title for the dialog mode.
  final Widget? dialogTitle;
  /// Button size for the trigger.
  final ButtonSize? size;
  /// Button density for the trigger.
  final ButtonDensity? density;
  /// Button shape for the trigger.
  final ButtonShape? shape;
  /// Custom dialog action buttons.
  final List<Widget> Function(BuildContext context, ObjectFormHandler<T> handler)? dialogActions;
  /// Whether the field is enabled.
  final bool? enabled;
  /// Whether to show the field decoration.
  final bool decorate;
  /// Creates an [ObjectFormField].
  const ObjectFormField({super.key, required this.value, this.onChanged, required this.placeholder, required this.builder, this.leading, this.trailing, this.mode = PromptMode.dialog, required this.editorBuilder, this.popoverAlignment, this.popoverAnchorAlignment, this.popoverPadding, this.dialogTitle, this.size, this.density, this.shape, this.dialogActions, this.enabled, this.decorate = true});
  State<ObjectFormField<T>> createState();
}
```
