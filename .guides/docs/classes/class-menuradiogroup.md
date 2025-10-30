---
title: "Class: MenuRadioGroup"
description: "Radio button group container for menu items."
---

```dart
/// Radio button group container for menu items.
///
/// Groups multiple [MenuRadio] items together with shared selection state.
/// Only one radio button in the group can be selected at a time.
///
/// Example:
/// ```dart
/// MenuRadioGroup<String>(
///   value: selectedOption,
///   onChanged: (context, value) => setState(() => selectedOption = value),
///   children: [
///     MenuRadio(value: 'option1', child: Text('Option 1')),
///     MenuRadio(value: 'option2', child: Text('Option 2')),
///   ],
/// )
/// ```
class MenuRadioGroup<T> extends StatelessWidget implements MenuItem {
  /// Currently selected value.
  final T? value;
  /// Callback when selection changes.
  final ContextedValueChanged<T>? onChanged;
  /// List of [MenuRadio] children.
  final List<Widget> children;
  /// Creates a radio group for menu items.
  ///
  /// Parameters:
  /// - [value] (T?): Currently selected value
  /// - [onChanged] (`ContextedValueChanged<T>?`): Selection change callback
  /// - [children] (`List<Widget>`): Radio button children
  const MenuRadioGroup({super.key, required this.value, required this.onChanged, required this.children});
  bool get hasLeading;
  PopoverController? get popoverController;
  Widget build(BuildContext context);
}
```
