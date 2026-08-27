---
title: "Class: ClipboardHandler"
description: "Handles serialization of [ChipInput] content to and from the clipboard.   When content is copied out of a [ChipInput], the selection is provided as a  list of [InlineSpan]s in which chips appear as [ChipSpan]s.  [serializeClipboard] turns that into a plain [String] for the system  clipboard, and [deserializeClipboard] turns pasted text back into spans so  that chips can be reconstructed on paste.   Note: chips render as [ChipSpan]s (a [WidgetSpan] subclass), so the span  lists use [InlineSpan] rather than [TextSpan]; a [ChipSpan] is not a  [TextSpan]."
---

```dart
/// Handles serialization of [ChipInput] content to and from the clipboard.
///
/// When content is copied out of a [ChipInput], the selection is provided as a
/// list of [InlineSpan]s in which chips appear as [ChipSpan]s.
/// [serializeClipboard] turns that into a plain [String] for the system
/// clipboard, and [deserializeClipboard] turns pasted text back into spans so
/// that chips can be reconstructed on paste.
///
/// Note: chips render as [ChipSpan]s (a [WidgetSpan] subclass), so the span
/// lists use [InlineSpan] rather than [TextSpan]; a [ChipSpan] is not a
/// [TextSpan].
abstract class ClipboardHandler<T> {
  /// Const constructor for subclasses.
  const ClipboardHandler();
  /// Converts pasted clipboard [content] into a list of spans to insert.
  ///
  /// Returned [ChipSpan]s are inserted as chips, while [TextSpan]s (and their
  /// text descendants) are inserted as plain text.
  List<InlineSpan> deserializeClipboard(String content);
  /// Converts the selected [content] into a plain string for the clipboard.
  ///
  /// Chips are provided as [ChipSpan]s so [ChipSpan.value] can be serialized
  /// instead of the internal placeholder character.
  String serializeClipboard(List<InlineSpan> content);
}
```
