---
title: "Class: TextFieldSetTextIntent"
description: "Intent to set the entire text field content to a specific value."
---

```dart
/// Intent to set the entire text field content to a specific value.
///
/// Replaces all existing text with the provided text.
/// Used with Flutter's Actions/Shortcuts system.
class TextFieldSetTextIntent extends Intent {
  /// Creates a [TextFieldSetTextIntent] with the new text.
  const TextFieldSetTextIntent({required this.text});
  /// The text to set as the field's content.
  final String text;
}
```
