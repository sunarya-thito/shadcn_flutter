---
title: "Class: MultipleChoiceTheme"
description: "Theme data for [MultipleChoice] and [MultipleAnswer]."
---

```dart
/// Theme data for [MultipleChoice] and [MultipleAnswer].
class MultipleChoiceTheme {
  /// Whether selections can be unselected.
  final bool? allowUnselect;
  /// Creates a [MultipleChoiceTheme].
  const MultipleChoiceTheme({this.allowUnselect});
  /// Returns a copy of this theme with the given fields replaced by the
  /// non-null parameters.
  MultipleChoiceTheme copyWith({ValueGetter<bool?>? allowUnselect});
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
