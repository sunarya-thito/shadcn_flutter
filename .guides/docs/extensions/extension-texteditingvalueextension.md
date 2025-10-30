---
title: "Extension: TextEditingValueExtension"
description: "Extension adding text replacement utilities to [TextEditingValue]."
---

```dart
/// Extension adding text replacement utilities to [TextEditingValue].
extension TextEditingValueExtension on TextEditingValue {
  /// Replaces the text while preserving selection within bounds.
  ///
  /// Adjusts the selection to stay within the new text length.
  ///
  /// Parameters:
  /// - [newText] (`String`, required): Replacement text.
  ///
  /// Returns: `TextEditingValue` — value with new text and adjusted selection.
  TextEditingValue replaceText(String newText);
}
```
