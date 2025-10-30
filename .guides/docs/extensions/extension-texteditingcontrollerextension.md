---
title: "Extension: TextEditingControllerExtension"
description: "Extension adding word-related utilities to [TextEditingController]."
---

```dart
/// Extension adding word-related utilities to [TextEditingController].
extension TextEditingControllerExtension on TextEditingController {
  /// Gets the word at the current cursor position.
  ///
  /// Returns `null` if the text is empty or the selection is not collapsed.
  String? get currentWord;
}
```
