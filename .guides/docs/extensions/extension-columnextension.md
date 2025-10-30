---
title: "Extension: ColumnExtension"
description: "Extension adding gap and separator utilities to [Column]."
---

```dart
/// Extension adding gap and separator utilities to [Column].
extension ColumnExtension on Column {
  /// Adds gaps between column children.
  ///
  /// Parameters:
  /// - [gap] (`double`, required): Vertical spacing between children.
  ///
  /// Returns: `Widget` — column with gaps.
  Widget gap(double gap);
  /// Adds separators between column children.
  ///
  /// Parameters:
  /// - [separator] (`Widget`, required): Widget to insert between children.
  ///
  /// Returns: `Widget` — column with separators.
  Widget separator(Widget separator);
}
```
