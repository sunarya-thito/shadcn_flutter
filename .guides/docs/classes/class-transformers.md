---
title: "Class: Transformers"
description: "Utility class providing static methods for interpolating between common types."
---

```dart
/// Utility class providing static methods for interpolating between common types.
///
/// This class contains type-specific lerp (linear interpolation) functions that
/// handle nullable values and perform smooth transitions between values.
///
/// ## Overview
///
/// Use [Transformers] when you need to interpolate between values of common types
/// like `double`, `int`, `Color`, `Offset`, or `Size`. Each method handles `null`
/// values gracefully by returning `null` if either input is `null`.
///
/// ## Example
///
/// ```dart
/// final color = Transformers.typeColor(Colors.red, Colors.blue, 0.5);
/// final position = Transformers.typeOffset(Offset.zero, Offset(100, 100), 0.3);
/// ```
class Transformers {
  /// Linearly interpolates between two nullable [double] values.
  ///
  /// ## Parameters
  ///
  /// * [a] - The starting value. If `null`, returns `null`.
  /// * [b] - The ending value. If `null`, returns `null`.
  /// * [t] - The interpolation factor, typically in range [0.0, 1.0].
  ///
  /// ## Returns
  ///
  /// The interpolated value, or `null` if either input is `null`.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final result = Transformers.typeDouble(0.0, 100.0, 0.5); // 50.0
  /// final nullResult = Transformers.typeDouble(null, 100.0, 0.5); // null
  /// ```
  static double? typeDouble(double? a, double? b, double t);
  /// Linearly interpolates between two nullable [int] values.
  ///
  /// ## Parameters
  ///
  /// * [a] - The starting integer. If `null`, returns `null`.
  /// * [b] - The ending integer. If `null`, returns `null`.
  /// * [t] - The interpolation factor, typically in range [0.0, 1.0].
  ///
  /// ## Returns
  ///
  /// The interpolated value rounded to the nearest integer, or `null` if either input is `null`.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final result = Transformers.typeInt(0, 100, 0.5); // 50
  /// final result2 = Transformers.typeInt(0, 100, 0.51); // 51 (rounded)
  /// ```
  static int? typeInt(int? a, int? b, double t);
  /// Linearly interpolates between two nullable [Color] values.
  ///
  /// ## Parameters
  ///
  /// * [a] - The starting color. If `null`, returns `null`.
  /// * [b] - The ending color. If `null`, returns `null`.
  /// * [t] - The interpolation factor, typically in range [0.0, 1.0].
  ///
  /// ## Returns
  ///
  /// The interpolated color using Flutter's `Color.lerp`, or `null` if either input is `null`.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final purple = Transformers.typeColor(Colors.red, Colors.blue, 0.5);
  /// final almostBlue = Transformers.typeColor(Colors.red, Colors.blue, 0.9);
  /// ```
  static Color? typeColor(Color? a, Color? b, double t);
  /// Linearly interpolates between two nullable [Offset] values.
  ///
  /// ## Parameters
  ///
  /// * [a] - The starting offset. If `null`, returns `null`.
  /// * [b] - The ending offset. If `null`, returns `null`.
  /// * [t] - The interpolation factor, typically in range [0.0, 1.0].
  ///
  /// ## Returns
  ///
  /// The interpolated offset with both dx and dy components interpolated,
  /// or `null` if either input is `null`.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final offset = Transformers.typeOffset(
  ///   Offset(0, 0),
  ///   Offset(100, 50),
  ///   0.5,
  /// ); // Offset(50, 25)
  /// ```
  static Offset? typeOffset(Offset? a, Offset? b, double t);
  /// Linearly interpolates between two nullable [Size] values.
  ///
  /// ## Parameters
  ///
  /// * [a] - The starting size. If `null`, returns `null`.
  /// * [b] - The ending size. If `null`, returns `null`.
  /// * [t] - The interpolation factor, typically in range [0.0, 1.0].
  ///
  /// ## Returns
  ///
  /// The interpolated size with both width and height components interpolated,
  /// or `null` if either input is `null`.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final size = Transformers.typeSize(
  ///   Size(100, 50),
  ///   Size(200, 150),
  ///   0.5,
  /// ); // Size(150, 100)
  /// ```
  static Size? typeSize(Size? a, Size? b, double t);
}
```
