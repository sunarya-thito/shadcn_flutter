---
title: "Class: RadioItem"
description: "A radio button item with optional leading and trailing widgets."
---

```dart
/// A radio button item with optional leading and trailing widgets.
///
/// Used within a [RadioGroup] to create selectable radio button options.
class RadioItem<T> extends StatefulWidget {
  /// Optional widget displayed before the radio button.
  final Widget? leading;
  /// Optional widget displayed after the radio button.
  final Widget? trailing;
  /// The value represented by this radio item.
  final T value;
  /// Whether this radio item is enabled.
  final bool enabled;
  /// Focus node for keyboard navigation.
  final FocusNode? focusNode;
  /// Creates a radio item.
  const RadioItem({super.key, this.leading, this.trailing, required this.value, this.enabled = true, this.focusNode});
  State<RadioItem<T>> createState();
}
```
