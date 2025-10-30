---
title: "Class: InputClearFeature"
description: "Adds a clear button to the input field."
---

```dart
/// Adds a clear button to the input field.
///
/// Provides a button that clears all text from the input when pressed.
/// Commonly used to improve user experience by offering quick text removal.
///
/// Example:
/// ```dart
/// TextField(
///   features: [
///     InputClearFeature(
///       position: InputFeaturePosition.trailing,
///     ),
///   ],
/// )
/// ```
class InputClearFeature extends InputFeature {
  /// Position of the clear button.
  final InputFeaturePosition position;
  /// Custom icon for the clear button.
  final Widget? icon;
  /// Creates an [InputClearFeature].
  ///
  /// Parameters:
  /// - [position] (`InputFeaturePosition`, default: `InputFeaturePosition.trailing`):
  ///   Where to place the clear button.
  /// - [icon] (`Widget?`, optional): Custom icon widget.
  /// - [visibility] (`InputFeatureVisibility`, optional): Controls visibility.
  /// - [skipFocusTraversal] (`bool`, optional): Whether to skip in focus order.
  const InputClearFeature({super.visibility, super.skipFocusTraversal, this.position = InputFeaturePosition.trailing, this.icon});
  InputFeatureState createState();
}
```
