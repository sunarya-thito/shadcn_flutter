---
title: "Class: IntrinsicTableSize"
description: "Table size mode that uses the intrinsic size of cell content."
---

```dart
/// Table size mode that uses the intrinsic size of cell content.
///
/// Sizes the column/row based on the natural size of its content.
/// May be expensive for large tables as it requires measuring content.
///
/// Example:
/// ```dart
/// IntrinsicTableSize() // Size based on content
/// ```
class IntrinsicTableSize extends TableSize {
  /// Creates an [IntrinsicTableSize].
  const IntrinsicTableSize();
}
```
