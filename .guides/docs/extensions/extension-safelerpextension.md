---
title: "Extension: SafeLerpExtension"
description: "Extension on nullable lerp functions to create non-null lerp helpers."
---

```dart
/// Extension on nullable lerp functions to create non-null lerp helpers.
extension SafeLerpExtension<T> on T? Function(T? a, T? b, double t) {
  /// Wraps this nullable lerp function to work with non-null values.
  ///
  /// Asserts that the lerp result is non-null.
  ///
  /// Parameters:
  /// - [a] (T, required): Start value
  /// - [b] (T, required): End value
  /// - [t] (double, required): Interpolation position
  ///
  /// Returns interpolated non-null value.
  T nonNull(T a, T b, double t);
}
```
