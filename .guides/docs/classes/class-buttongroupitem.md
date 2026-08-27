---
title: "Class: ButtonGroupItem"
description: "A widget for use within a [ButtonGroup] that manages focus and paint order without flex behavior.   [ButtonGroupItem] is designed to be used as a child of [ButtonGroup] to allow buttons to maintain their intrinsic size while ensuring that the focused button is painted above its siblings.  This is useful for buttons that should not expand but still need to be visually prominent when focused."
---

```dart
/// A widget for use within a [ButtonGroup] that manages focus and paint order without flex behavior.
///
/// [ButtonGroupItem] is designed to be used as a child of [ButtonGroup] to allow buttons to maintain their intrinsic size while ensuring that the focused button is painted above its siblings.
/// This is useful for buttons that should not expand but still need to be visually prominent when focused.
class ButtonGroupItem extends StatefulWidget {
  /// The child widget to be displayed within the button group item.
  final Widget child;
  /// Creates a [ButtonGroupItem] widget with the specified child.
  ///
  /// Parameters:
  /// - [child] (Widget, required): The widget to display within the button group item.
  const ButtonGroupItem({super.key, required this.child});
  State<ButtonGroupItem> createState();
}
```
