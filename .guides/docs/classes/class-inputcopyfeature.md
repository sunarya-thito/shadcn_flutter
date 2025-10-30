---
title: "Class: InputCopyFeature"
description: "Adds a copy button to the input field."
---

```dart
/// Adds a copy button to the input field.
///
/// Provides a button that copies the current input text to the clipboard.
/// Useful for allowing users to easily copy generated or displayed content.
///
/// Example:
/// ```dart
/// TextField(
///   controller: TextEditingController(text: 'Copy me!'),
///   features: [
///     InputCopyFeature(),
///   ],
/// )
/// ```
class InputCopyFeature extends InputFeature {
  /// Position of the copy button.
  final InputFeaturePosition position;
  /// Custom icon for the copy button.
  final Widget? icon;
  /// Creates an [InputCopyFeature].
  ///
  /// Parameters:
  /// - [position] (`InputFeaturePosition`, default: `InputFeaturePosition.trailing`):
  ///   Where to place the copy button.
  /// - [icon] (`Widget?`, optional): Custom icon widget.
  /// - [visibility] (`InputFeatureVisibility`, optional): Controls visibility.
  /// - [skipFocusTraversal] (`bool`, optional): Whether to skip in focus order.
  const InputCopyFeature({super.visibility, super.skipFocusTraversal, this.position = InputFeaturePosition.trailing, this.icon});
  InputFeatureState createState();
}
```
