---
title: "Enum: AutoCompleteMode"
description: "Text replacement strategies for autocomplete suggestion application."
---

```dart
/// Text replacement strategies for autocomplete suggestion application.
///
/// Defines how selected autocomplete suggestions modify the existing text
/// field content. Each mode provides different behavior for integrating
/// suggestions with current text.
enum AutoCompleteMode {
  /// Appends the suggestion to the current text field content.
  ///
  /// Adds the selected suggestion at the current cursor position without
  /// removing any existing text. Useful for building compound inputs or
  /// adding multiple values.
  append,
  /// Replaces the current word with the selected suggestion.
  ///
  /// Identifies the word boundary around the cursor and replaces only that
  /// word with the suggestion. This is the default mode and most common
  /// autocomplete behavior for text completion.
  replaceWord,
  /// Replaces all text field content with the selected suggestion.
  ///
  /// Clears the entire text field and sets it to the selected suggestion.
  /// Useful for search fields or when suggestions represent complete values
  /// rather than partial completions.
  replaceAll,
}
```
