---
title: "Class: TextFieldAppendTextIntent"
description: "Intent to append text to the current text field content."
---

```dart
/// Intent to append text to the current text field content.
///
/// Used with Flutter's Actions/Shortcuts system to programmatically
/// append text to a text field.
class TextFieldAppendTextIntent extends Intent {
  /// Creates a [TextFieldAppendTextIntent] with the text to append.
  const TextFieldAppendTextIntent({required this.text});
  /// The text to append to the current content.
  final String text;
}
```
