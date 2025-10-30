---
title: "Class: TextFieldSetSelectionIntent"
description: "Intent to set the text selection in the text field."
---

```dart
/// Intent to set the text selection in the text field.
///
/// Used with Flutter's Actions/Shortcuts system to programmatically
/// control cursor position and text selection.
class TextFieldSetSelectionIntent extends Intent {
  /// The text selection to apply.
  final TextSelection selection;
  /// Creates a [TextFieldSetSelectionIntent] with the selection.
  const TextFieldSetSelectionIntent({required this.selection});
}
```
