---
title: "Class: StaticPart"
description: "A part that displays static, non-editable text."
---

```dart
/// A part that displays static, non-editable text.
class StaticPart extends InputPart {
  /// The static text to display.
  final String text;
  /// Creates a [StaticPart] with the specified static text.
  ///
  /// Parameters:
  /// - [text] (`String`, required): The immutable text content to display.
  ///
  /// Example:
  /// ```dart
  /// const StaticPart('/')
  /// ```
  const StaticPart(this.text);
  Widget build(BuildContext context, FormattedInputData data);
  String get partKey;
  String toString();
}
```
