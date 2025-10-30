---
title: "Class: ChipEditingController"
description: "A text editing controller that supports inline chip widgets."
---

```dart
/// A text editing controller that supports inline chip widgets.
///
/// Extends [TextEditingController] to manage text with embedded chip objects
/// represented by special Unicode codepoints from the Private Use Area (U+E000-U+F8FF).
/// Each chip is mapped to a unique codepoint allowing up to 6400 chips per controller.
///
/// Use this when you need to display removable tags or tokens within a text field,
/// such as email recipients, keywords, or selected items.
///
/// Example:
/// ```dart
/// final controller = ChipEditingController<String>(
///   initialChips: ['tag1', 'tag2'],
/// );
/// ```
class ChipEditingController<T> extends TextEditingController {
  /// Factory constructor creating a chip editing controller.
  ///
  /// Optionally initializes with [text] and [initialChips].
  factory ChipEditingController({String? text, List<T>? initialChips});
  set text(String newText);
  set value(TextEditingValue newValue);
  /// Returns an unmodifiable list of all chips in the controller.
  List<T> get chips;
  /// Sets the chips in this controller, replacing all existing chips.
  set chips(List<T> newChips);
  /// Removes all chips from the controller, leaving only plain text.
  void removeAllChips();
  TextSpan buildTextSpan({required BuildContext context, TextStyle? style, required bool withComposing});
  /// Returns the plain text without chip characters.
  String get plainText;
  /// Returns the text at the current cursor position.
  String get textAtCursor;
  /// Inserts a chip at the cursor position by converting the text at cursor.
  ///
  /// Uses [chipConverter] to convert the text at cursor to a chip.
  void insertChipAtCursor(T? Function(String chipText) chipConverter);
  /// Clears the text at the current cursor position.
  void clearTextAtCursor();
  /// Appends a chip at the end of the chip sequence.
  void appendChip(T chip);
  /// Appends a chip at the current cursor position.
  void appendChipAtCursor(T chip);
  /// Inserts a chip at a specific position in the text.
  void insertChip(T chip);
  /// Removes the specified chip from the controller.
  void removeChip(T chip);
}
```
