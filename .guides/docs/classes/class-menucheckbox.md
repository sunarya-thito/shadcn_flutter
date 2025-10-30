---
title: "Class: MenuCheckbox"
description: "Checkbox menu item with checked/unchecked state."
---

```dart
/// Checkbox menu item with checked/unchecked state.
///
/// Displays a checkmark when selected. Used for togglable menu options.
///
/// Example:
/// ```dart
/// MenuCheckbox(
///   value: showToolbar,
///   onChanged: (context, value) => setState(() => showToolbar = value),
///   child: Text('Show Toolbar'),
/// )
/// ```
class MenuCheckbox extends StatelessWidget implements MenuItem {
  /// Current checked state.
  final bool value;
  /// Callback when checkbox state changes.
  final ContextedValueChanged<bool>? onChanged;
  /// Content widget displayed for this option.
  final Widget child;
  /// Optional trailing widget (e.g., keyboard shortcut).
  final Widget? trailing;
  /// Whether this checkbox is enabled.
  final bool enabled;
  /// Whether checking this box closes the menu automatically.
  final bool autoClose;
  /// Creates a checkbox menu item.
  ///
  /// Parameters:
  /// - [value] (bool): Current checked state, defaults to false
  /// - [onChanged] (`ContextedValueChanged<bool>?`): State change callback
  /// - [child] (Widget, required): Display content
  /// - [trailing] (Widget?): Optional trailing widget
  /// - [enabled] (bool): Whether enabled, defaults to true
  /// - [autoClose] (bool): Whether to auto-close menu, defaults to true
  const MenuCheckbox({super.key, this.value = false, this.onChanged, required this.child, this.trailing, this.enabled = true, this.autoClose = true});
  bool get hasLeading;
  PopoverController? get popoverController;
  Widget build(BuildContext context);
}
```
