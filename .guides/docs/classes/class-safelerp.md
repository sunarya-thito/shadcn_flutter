---
title: "Class: SafeLerp"
description: "A utility for safely interpolating between values of type [T]."
---

```dart
/// A utility for safely interpolating between values of type [T].
class SafeLerp<T> {
  /// Nullable lerp function that can handle null values.
  final T? Function(T? a, T? b, double t) nullableLerp;
  /// Creates a SafeLerp with the given nullable lerp function.
  const SafeLerp(this.nullableLerp);
  /// Interpolates between non-null values.
  ///
  /// Asserts that the result is non-null.
  ///
  /// Parameters:
  /// - [a] (T, required): Start value
  /// - [b] (T, required): End value
  /// - [t] (double, required): Interpolation position (0.0 to 1.0)
  ///
  /// Returns interpolated value.
  T lerp(T a, T b, double t);
}
```
