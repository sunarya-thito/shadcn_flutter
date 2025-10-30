---
title: "Class: InputTrailingFeature"
description: "Adds a custom widget to the trailing (right) side of the input field."
---

```dart
/// Adds a custom widget to the trailing (right) side of the input field.
///
/// Allows you to place any widget after the input text, such as icons,
/// buttons, or other decorative elements.
///
/// Example:
/// ```dart
/// TextField(
///   features: [
///     InputTrailingFeature(
///       Icon(Icons.arrow_forward),
///     ),
///   ],
/// )
/// ```
class InputTrailingFeature extends InputFeature {
  /// The widget to display on the trailing side.
  final Widget suffix;
  /// Creates an [InputTrailingFeature].
  ///
  /// Parameters:
  /// - [suffix] (`Widget`, required): The widget to show after the input.
  /// - [visibility] (`InputFeatureVisibility`, optional): Controls visibility.
  /// - [skipFocusTraversal] (`bool`, optional): Whether to skip in focus order.
  const InputTrailingFeature(this.suffix, {super.visibility, super.skipFocusTraversal});
  InputFeatureState createState();
}
```
