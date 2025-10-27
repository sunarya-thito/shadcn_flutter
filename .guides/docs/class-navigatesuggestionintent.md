---
title: "Class: NavigateSuggestionIntent"
description: "Intent for navigating through autocomplete suggestions via keyboard."
---

```dart
/// Intent for navigating through autocomplete suggestions via keyboard.
///
/// Used internally by [AutoComplete] to handle arrow key navigation within
/// the suggestion list. The [direction] indicates movement direction where
/// positive values move down and negative values move up.
class NavigateSuggestionIntent extends Intent {
  /// Direction of navigation through suggestions.
  ///
  /// Positive values move down in the list, negative values move up.
  /// The magnitude is typically 1 for single-step navigation.
  final int direction;
  /// Creates a navigation intent with the specified [direction].
  const NavigateSuggestionIntent(this.direction);
}
```
