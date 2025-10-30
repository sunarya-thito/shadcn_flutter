---
title: "Extension: RowExtension"
description: "Extension adding gap and separator utilities to [Row]."
---

```dart
/// Extension adding gap and separator utilities to [Row].
extension RowExtension on Row {
  /// Adds gaps between row children.
  ///
  /// Parameters:
  /// - [gap] (`double`, required): Horizontal spacing between children.
  ///
  /// Returns: `Widget` — row with gaps.
  Widget gap(double gap);
  /// Adds separators between row children.
  ///
  /// Parameters:
  /// - [separator] (`Widget`, required): Widget to insert between children.
  ///
  /// Returns: `Widget` — row with separators.
  Widget separator(Widget separator);
}
```
