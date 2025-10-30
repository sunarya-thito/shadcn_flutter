---
title: "Class: NavigationItem"
description: "Selectable navigation item with selection state management."
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
///   index: 0,
///   label: Text('Home'),
///   child: Icon(Icons.home),
///   selected: selectedIndex == 0,
///   onChanged: (selected) => setState(() => selectedIndex = 0),
/// )
/// ```
class NavigationItem extends AbstractNavigationButton {
  /// Custom style when item is selected.
  final AbstractButtonStyle? selectedStyle;
  /// Whether this item is currently selected.
  final bool? selected;
  /// Callback when selection state changes.
  final ValueChanged<bool>? onChanged;
  /// Optional index for selection management.
  final int? index;
  /// Creates a navigation item.
  ///
  /// Parameters:
  /// - [child] (Widget, required): Icon or content widget
  /// - [selectedStyle] (AbstractButtonStyle?): Style when selected
  /// - [selected] (bool?): Current selection state
  /// - [onChanged] (`ValueChanged<bool>?`): Selection change callback
  /// - [index] (int?): Item index for selection
  /// - [label] (Widget?): Optional label text
  /// - [spacing] (double?): Space between icon and label
  /// - [style] (AbstractButtonStyle?): Default style
  /// - [alignment] (AlignmentGeometry?): Content alignment
  /// - [enabled] (bool?): Whether enabled for interaction
  /// - [overflow] (TextOverflow?): Label overflow behavior
  /// - [marginAlignment] (AlignmentGeometry?): Margin alignment
  const NavigationItem({super.key, this.selectedStyle, this.selected, this.onChanged, super.label, super.spacing, super.style, super.alignment, this.index, super.enabled, super.overflow, super.marginAlignment, required super.child});
  bool get selectable;
  State<AbstractNavigationButton> createState();
}
```
