---
title: "Class: DefaultChipClipboardHandler"
description: "Default [ClipboardHandler] that serializes chips with [chipSerializer] (or  [Object.toString]) and pastes clipboard text as plain text."
---

```dart
/// Default [ClipboardHandler] that serializes chips with [chipSerializer] (or
/// [Object.toString]) and pastes clipboard text as plain text.
class DefaultChipClipboardHandler<T> extends ClipboardHandler<T> {
  /// Converts a chip value into its clipboard string representation.
  ///
  /// Falls back to [Object.toString] when null.
  final String Function(T value)? chipSerializer;
  /// Separator inserted between two adjacent chips when serializing.
  final String chipSeparator;
  /// Creates a [DefaultChipClipboardHandler].
  const DefaultChipClipboardHandler({this.chipSerializer, this.chipSeparator = ''});
  List<InlineSpan> deserializeClipboard(String content);
  String serializeClipboard(List<InlineSpan> content);
}
```
