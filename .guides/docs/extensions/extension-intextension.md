---
title: "Extension: IntExtension"
description: "Extension adding min/max utilities to [int]."
---

```dart
/// Extension adding min/max utilities to [int].
extension IntExtension on int {
  /// Returns the minimum of this value and another.
  ///
  /// Parameters:
  /// - [other] (`int`, required): Value to compare.
  ///
  /// Returns: `int` — the smaller value.
  int min(int other);
  /// Returns the maximum of this value and another.
  ///
  /// Parameters:
  /// - [other] (`int`, required): Value to compare.
  ///
  /// Returns: `int` — the larger value.
  int max(int other);
}
```
