---
title: "Class: AcceptSuggestionIntent"
description: "Intent for accepting the currently selected autocomplete suggestion."
---

```dart
/// Intent for accepting the currently selected autocomplete suggestion.
///
/// Used internally by [AutoComplete] to handle suggestion acceptance via
/// keyboard shortcuts (typically Tab or Enter). Triggers the completion
/// logic to apply the selected suggestion to the text field.
class AcceptSuggestionIntent extends Intent {
  /// Creates an accept suggestion intent.
  const AcceptSuggestionIntent();
}
```
