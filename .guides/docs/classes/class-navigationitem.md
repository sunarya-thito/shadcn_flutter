---
title: "Class: NavigationItem"
description: "Selectable navigation item with selection state management.   Represents a clickable navigation item that can be selected. Supports  custom styling for selected/unselected states, labels, and icons.   Example:  ```dart  NavigationItem(    key: ValueKey('home'),    label: Text('Home'),    child: Icon(Icons.home),    selected: selectedKey == ValueKey('home'),    onChanged: (selected) => setState(() => selectedKey = ValueKey('home')),  )  )  ```"
---

```dart
/// Selectable navigation item with selection state management.
///
/// Represents a clickable navigation item that can be selected. Supports
/// custom styling for selected/unselected states, labels, and icons.
///
/// Example:
/// ```dart
/// NavigationItem(
///   key: ValueKey('home'),
///   label: Text('Home'),
///   child: Icon(Icons.home),
///   selected: selectedKey == ValueKey('home'),
///   onChanged: (selected) => setState(() => selectedKey = ValueKey('home')),
/// )
/// )
/// ```
class NavigationItem extends AbstractNavigationButton {
  /// Custom style when item is selected.
  final AbstractButtonStyle? selectedStyle;
  /// Whether this item is currently selected.
  final bool? selected;
  /// Callback when selection state changes.
  final ValueChanged<bool>? onChanged;
  /// Creates a navigation item.
  ///
  /// Parameters:
  /// - [child] (Widget, required): Icon or content widget
  /// - [selectedStyle] (AbstractButtonStyle?): Style when selected
  /// - [selected] (bool?): Current selection state
  /// - [onChanged] (`ValueChanged<bool>?`): Selection change callback
  /// - [label] (Widget?): Optional label text
  /// - [spacing] (double?): Space between icon and label
  /// - [style] (AbstractButtonStyle?): Default style
  /// - [alignment] (AlignmentGeometry?): Content alignment
  /// - [enabled] (bool?): Whether enabled for interaction
  /// - [overflow] (NavigationOverflow): Overflow behavior
  /// - [marginAlignment] (AlignmentGeometry?): Margin alignment
  const NavigationItem({super.key, this.selectedStyle, this.selected, this.onChanged, super.label, super.spacing, super.style, super.alignment, super.enabled, super.overflow, super.marginAlignment, required super.child});
  State<AbstractNavigationButton> createState();
}
```
