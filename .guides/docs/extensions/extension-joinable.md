---
title: "Extension: Joinable"
description: "Extension for joining lists of widgets with a separator."
---

```dart
/// Extension for joining lists of widgets with a separator.
extension Joinable<T extends Widget> on List<T> {
  /// Joins widgets with a separator between each item.
  ///
  /// Parameters:
  /// - [separator] (`T`, required): Widget to insert between items.
  ///
  /// Returns: `List<T>` — list with separators inserted.
  List<T> joinSeparator(T separator);
}
```
