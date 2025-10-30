---
title: "Class: TextFieldReplaceCurrentWordIntent"
description: "Intent to replace the current word in the text field."
---

```dart
/// Intent to replace the current word in the text field.
///
/// Replaces the word at the current cursor position with new text.
/// Used with Flutter's Actions/Shortcuts system.
class TextFieldReplaceCurrentWordIntent extends Intent {
  /// Creates a [TextFieldReplaceCurrentWordIntent] with replacement text.
  const TextFieldReplaceCurrentWordIntent({required this.text});
  /// The text to replace the current word with.
  final String text;
}
```
