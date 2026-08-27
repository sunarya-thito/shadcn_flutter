---
title: "Class: ButtonGroupFlexible"
description: "A flexible widget for use within a [ButtonGroup] that manages focus and paint order.   [ButtonGroupFlexible] is designed to be used as a child of [ButtonGroup] to allow  buttons to flexibly expand while ensuring that the focused button is painted above its siblings."
---

```dart
/// A flexible widget for use within a [ButtonGroup] that manages focus and paint order.
///
/// [ButtonGroupFlexible] is designed to be used as a child of [ButtonGroup] to allow
/// buttons to flexibly expand while ensuring that the focused button is painted above its siblings.
class ButtonGroupFlexible extends StatefulWidget {
  /// The flex factor to determine how much space this widget should take relative to its siblings.
  final int flex;
  /// The fit property to determine how the child should be inscribed into the available space.
  final FlexFit fit;
  /// The child widget to be displayed within the flexible area.
  final Widget child;
  /// Creates a [ButtonGroupFlexible] widget with the specified flex and fit properties.
  ///
  /// Parameters:
  /// - [flex] (int, default: 1): The flex factor for this widget.
  /// - [fit] (FlexFit, default: FlexFit.loose): How the child should be inscribed into the available space.
  /// - [child] (Widget, required): The widget to display within the flexible area.
  const ButtonGroupFlexible({super.key, this.flex = 1, this.fit = FlexFit.loose, required this.child});
  State<ButtonGroupFlexible> createState();
}
```
