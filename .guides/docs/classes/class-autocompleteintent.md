---
title: "Class: AutoCompleteIntent"
description: "An intent representing an autocomplete suggestion selection."
---

```dart
/// An intent representing an autocomplete suggestion selection.
///
/// Used by the autocomplete system to handle suggestion selections
/// with different modes of completion.
class AutoCompleteIntent extends Intent {
  /// The suggestion text to be completed.
  final String suggestion;
  /// The mode determining how the completion should be applied.
  final AutoCompleteMode mode;
  /// Creates an autocomplete intent with the specified suggestion and mode.
  const AutoCompleteIntent(this.suggestion, this.mode);
}
```
