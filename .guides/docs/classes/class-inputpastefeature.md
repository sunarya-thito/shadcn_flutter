---
title: "Class: InputPasteFeature"
description: "Adds a paste button to the input field."
---

```dart
/// Adds a paste button to the input field.
///
/// Provides a button that pastes content from the clipboard into the input.
/// Useful for improving user experience when entering copied data.
///
/// Example:
/// ```dart
/// TextField(
///   features: [
///     InputPasteFeature(
///       position: InputFeaturePosition.trailing,
///     ),
///   ],
/// )
/// ```
class InputPasteFeature extends InputFeature {
  /// Position of the paste button.
  final InputFeaturePosition position;
  /// Custom icon for the paste button.
  final Widget? icon;
  /// Creates an [InputPasteFeature].
  ///
  /// Parameters:
  /// - [position] (`InputFeaturePosition`, default: `InputFeaturePosition.trailing`):
  ///   Where to place the paste button.
  /// - [icon] (`Widget?`, optional): Custom icon widget.
  /// - [visibility] (`InputFeatureVisibility`, optional): Controls visibility.
  /// - [skipFocusTraversal] (`bool`, optional): Whether to skip in focus order.
  const InputPasteFeature({super.visibility, super.skipFocusTraversal, this.position = InputFeaturePosition.trailing, this.icon});
  InputFeatureState createState();
}
```
