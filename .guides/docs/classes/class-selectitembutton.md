---
title: "Class: SelectItemButton"
description: "A button widget representing a selectable item in a dropdown menu."
---

```dart
/// A button widget representing a selectable item in a dropdown menu.
///
/// Used within select dropdowns to create clickable option items.
class SelectItemButton<T> extends StatelessWidget {
  /// The value this item represents.
  final T value;
  /// The child widget to display as the item content.
  final Widget child;
  /// The button style for this item.
  final AbstractButtonStyle style;
  /// Whether this item is enabled.
  final bool? enabled;
  /// Creates a select item button.
  const SelectItemButton({super.key, required this.value, required this.child, this.enabled, this.style = const ButtonStyle.ghost()});
  Widget build(BuildContext context);
}
```
