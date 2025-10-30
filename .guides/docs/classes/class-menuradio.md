---
title: "Class: MenuRadio"
description: "Individual radio button item within a [MenuRadioGroup]."
---

```dart
/// Individual radio button item within a [MenuRadioGroup].
///
/// Displays a radio button indicator when selected and integrates with
/// the parent radio group for selection management.
class MenuRadio<T> extends StatelessWidget {
  /// The value this radio button represents.
  final T value;
  /// Content widget displayed for this option.
  final Widget child;
  /// Optional trailing widget (e.g., keyboard shortcut).
  final Widget? trailing;
  /// Focus node for keyboard navigation.
  final FocusNode? focusNode;
  /// Whether this radio button is enabled.
  final bool enabled;
  /// Whether selecting this radio closes the menu automatically.
  final bool autoClose;
  /// Creates a radio button menu item.
  ///
  /// Must be a child of [MenuRadioGroup].
  ///
  /// Parameters:
  /// - [value] (T, required): Value for this option
  /// - [child] (Widget, required): Display content
  /// - [trailing] (Widget?): Optional trailing widget
  /// - [focusNode] (FocusNode?): Focus node for navigation
  /// - [enabled] (bool): Whether enabled, defaults to true
  /// - [autoClose] (bool): Whether to auto-close menu, defaults to true
  const MenuRadio({super.key, required this.value, required this.child, this.trailing, this.focusNode, this.enabled = true, this.autoClose = true});
  Widget build(BuildContext context);
}
```
