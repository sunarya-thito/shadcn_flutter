---
title: "Extension: DoubleExtension"
description: "Extension adding min/max utilities to [double]."
---

```dart
/// Extension adding min/max utilities to [double].
extension DoubleExtension on double {
  /// Returns the minimum of this value and another.
  ///
  /// Parameters:
  /// - [other] (`double`, required): Value to compare.
  ///
  /// Returns: `double` — the smaller value.
  double min(double other);
  /// Returns the maximum of this value and another.
  ///
  /// Parameters:
  /// - [other] (`double`, required): Value to compare.
  ///
  /// Returns: `double` — the larger value.
  double max(double other);
}
```
