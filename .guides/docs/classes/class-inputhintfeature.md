---
title: "Class: InputHintFeature"
description: "Adds a hint/info button to the input field with a popover."
---

```dart
/// Adds a hint/info button to the input field with a popover.
///
/// Displays an icon button that shows a popover with additional information
/// when clicked. Optionally supports keyboard shortcuts (F1) to open the hint.
///
/// Example:
/// ```dart
/// TextField(
///   features: [
///     InputHintFeature(
///       popupBuilder: (context) => const Text('Enter your email'),
///       icon: Icon(Icons.help),
///     ),
///   ],
/// )
/// ```
class InputHintFeature extends InputFeature {
  /// Builder for the hint popover content.
  final WidgetBuilder popupBuilder;
  /// Custom icon to display (defaults to info icon).
  final Widget? icon;
  /// Position of the hint button.
  final InputFeaturePosition position;
  /// Whether to enable keyboard shortcut (F1) to show the hint.
  final bool enableShortcuts;
  /// Creates an [InputHintFeature].
  ///
  /// Parameters:
  /// - [popupBuilder] (`WidgetBuilder`, required): Builds the hint content.
  /// - [position] (`InputFeaturePosition`, default: `InputFeaturePosition.trailing`):
  ///   Where to place the hint icon.
  /// - [icon] (`Widget?`, optional): Custom icon widget.
  /// - [enableShortcuts] (`bool`, default: `true`): Enable F1 keyboard shortcut.
  /// - [visibility] (`InputFeatureVisibility`, optional): Controls visibility.
  /// - [skipFocusTraversal] (`bool`, optional): Whether to skip in focus order.
  const InputHintFeature({super.visibility, super.skipFocusTraversal, required this.popupBuilder, this.position = InputFeaturePosition.trailing, this.icon, this.enableShortcuts = true});
  InputFeatureState createState();
}
```
