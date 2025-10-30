---
title: "Class: InputRevalidateFeature"
description: "Adds a revalidate button to the input field."
---

```dart
/// Adds a revalidate button to the input field.
///
/// Provides a button that triggers form validation when pressed.
/// Useful for manually triggering validation after user input.
///
/// Example:
/// ```dart
/// TextField(
///   features: [
///     InputRevalidateFeature(),
///   ],
/// )
/// ```
class InputRevalidateFeature extends InputFeature {
  /// Position of the revalidate button.
  final InputFeaturePosition position;
  /// Custom icon for the revalidate button.
  final Widget? icon;
  /// Creates an [InputRevalidateFeature].
  ///
  /// Parameters:
  /// - [position] (`InputFeaturePosition`, default: `InputFeaturePosition.trailing`):
  ///   Where to place the revalidate button.
  /// - [icon] (`Widget?`, optional): Custom icon widget.
  /// - [visibility] (`InputFeatureVisibility`, optional): Controls visibility.
  /// - [skipFocusTraversal] (`bool`, optional): Whether to skip in focus order.
  const InputRevalidateFeature({super.visibility, super.skipFocusTraversal, this.position = InputFeaturePosition.trailing, this.icon});
  InputFeatureState createState();
}
```
