---
title: "Class: Density"
description: "Defines density settings for spacing throughout the UI."
---

```dart
/// Defines density settings for spacing throughout the UI.
///
/// [Density] provides base values that are multiplied by padding constants
/// (e.g., [padXs], [padSm], [padLg]) to produce final pixel values.
/// This allows consistent scaling of all spacing when switching density modes.
///
/// There are two types of padding:
/// - **Container padding**: Used for widgets that contain multiple children
///   (e.g., Card, AlertDialog, ListView panels)
/// - **Content padding**: Used for widgets that contain content
///   (e.g., Button, TextField, Chip)
///
/// Example:
/// ```dart
/// // Apply compact density to reduce spacing
/// Theme(
///   data: ThemeData(density: Density.compactDensity),
///   child: MyApp(),
/// )
/// ```
class Density {
  /// Linearly interpolates between two density settings.
  ///
  /// Parameters:
  /// - [a] (`Density`, required): The starting density.
  /// - [b] (`Density`, required): The ending density.
  /// - [t] (`double`, required): The interpolation factor (0.0 to 1.0).
  static Density lerp(Density a, Density b, double t);
  /// Default density with standard spacing (16px base).
  static const defaultDensity = Density(baseContainerPadding: 16.0, baseGap: 8.0, baseContentPadding: 16.0);
  /// Reduced density for slightly more compact layouts (12px base).
  static const reducedDensity = Density(baseContainerPadding: 12.0, baseGap: 6.0, baseContentPadding: 12.0);
  /// Spacious density for more generous spacing (20px base).
  static const spaciousDensity = Density(baseContainerPadding: 20.0, baseGap: 10.0, baseContentPadding: 20.0);
  /// Compact density for maximizing content density (8px base).
  static const compactDensity = Density(baseContainerPadding: 8.0, baseGap: 4.0, baseContentPadding: 8.0);
  /// Base padding for container widgets (Card, AlertDialog, etc.).
  final double baseContainerPadding;
  /// Base gap between items in rows, columns, and flex layouts.
  final double baseGap;
  /// Base padding for content widgets (Button, TextField, etc.).
  final double baseContentPadding;
  /// Creates a [Density] with custom base values.
  ///
  /// Parameters:
  /// - [baseContainerPadding] (`double`, required): Base padding for containers.
  /// - [baseGap] (`double`, required): Base gap between items.
  /// - [baseContentPadding] (`double`, required): Base padding for content.
  const Density({required this.baseContainerPadding, required this.baseGap, required this.baseContentPadding});
  /// Creates a copy of this density with the specified values replaced.
  Density copyWith({ValueGetter<double>? baseContainerPadding, ValueGetter<double>? baseGap, ValueGetter<double>? baseContentPadding});
  String toString();
  bool operator ==(Object other);
  int get hashCode;
}
```
