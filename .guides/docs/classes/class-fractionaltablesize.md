---
title: "Class: FractionalTableSize"
description: "Table size mode that uses a fractional value of the table's size."
---

```dart
/// Table size mode that uses a fractional value of the table's size.
///
/// Sizes the column/row based on a fractional value of the table's size.
///
/// Example:
/// ```dart
/// FractionalTableSize(0.5) // 50% of table size
/// ```
class FractionalTableSize extends TableSize {
  /// The fractional value of the table's size.
  final double fraction;
  /// Creates a [FractionalTableSize] with the specified fractional value.
  const FractionalTableSize(this.fraction);
}
```
