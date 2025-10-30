---
title: "Class: SelectItem"
description: "Represents a selectable item in a dropdown menu."
---

```dart
/// Represents a selectable item in a dropdown menu.
///
/// Used within select popups to define individual selectable options.
/// Automatically applies selected state styling when the item matches
/// the current selection.
///
/// Example:
/// ```dart
/// SelectItem(
///   value: 'option1',
///   builder: (context) => Text('Option 1'),
/// )
/// ```
class SelectItem extends StatelessWidget {
  /// Builder for the item's content.
  final WidgetBuilder builder;
  /// The value associated with this item.
  final Object? value;
  /// Creates a [SelectItem].
  ///
  /// Parameters:
  /// - [value] (`Object?`, required): Item value.
  /// - [builder] (`WidgetBuilder`, required): Content builder.
  const SelectItem({super.key, required this.value, required this.builder});
  Widget build(BuildContext context);
}
```
