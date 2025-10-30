---
title: "Class: TableRef"
description: "Reference to a table row or column by index and span."
---

```dart
/// Reference to a table row or column by index and span.
///
/// Used to identify specific rows or columns in table layouts,
/// particularly for frozen/pinned row and column functionality.
///
/// Example:
/// ```dart
/// TableRef(0, 2) // References rows/columns 0 and 1
/// TableRef(5)    // References row/column 5 with span of 1
/// ```
class TableRef {
  /// Starting index of the reference.
  final int index;
  /// Number of rows/columns spanned. Defaults to 1.
  final int span;
  /// Creates a [TableRef].
  const TableRef(this.index, [this.span = 1]);
  /// Tests if this reference includes the given index and span.
  bool test(int index, int span);
}
```
