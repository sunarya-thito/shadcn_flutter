---
title: "Class: ScaffoldBarData"
description: "Data class for identifying scaffold bar (header/footer) positioning."
---

```dart
/// Data class for identifying scaffold bar (header/footer) positioning.
///
/// Provides context about a bar's position within the scaffold layout,
/// including whether it's a header or footer and its index among siblings.
class ScaffoldBarData {
  /// Whether this bar is in the header section (vs footer).
  final bool isHeader;
  /// Zero-based index of this child bar.
  final int childIndex;
  /// Total number of children in this section.
  final int childrenCount;
  /// Creates [ScaffoldBarData].
  const ScaffoldBarData({this.isHeader = true, required this.childIndex, required this.childrenCount});
}
```
