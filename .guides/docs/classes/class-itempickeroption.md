---
title: "Class: ItemPickerOption"
description: "A selectable option within an item picker."
---

```dart
/// A selectable option within an item picker.
///
/// Wraps an item with selection behavior, applying different styles based on
/// whether it's currently selected. Commonly used inside [ItemPickerDialog]
/// to create selectable items.
///
/// Example:
/// ```dart
/// ItemPickerOption<Color>(
///   value: Colors.red,
///   child: Container(color: Colors.red, width: 50, height: 50),
/// )
/// ```
class ItemPickerOption<T> extends StatelessWidget {
  /// The value this option represents.
  final T value;
  /// Optional label widget displayed with the option.
  final Widget? label;
  /// The main child widget representing the option.
  final Widget child;
  /// Custom style for the option when not selected.
  final AbstractButtonStyle? style;
  /// Custom style for the option when selected.
  final AbstractButtonStyle? selectedStyle;
  /// Creates an [ItemPickerOption].
  ///
  /// Parameters:
  /// - [value] (`T`, required): The value this option represents.
  /// - [child] (`Widget`, required): The widget to display.
  /// - [style] (`AbstractButtonStyle?`, optional): Style when not selected.
  /// - [selectedStyle] (`AbstractButtonStyle?`, optional): Style when selected.
  /// - [label] (`Widget?`, optional): Optional label widget.
  const ItemPickerOption({super.key, required this.value, required this.child, this.style, this.selectedStyle, this.label});
  Widget build(BuildContext context);
}
```
