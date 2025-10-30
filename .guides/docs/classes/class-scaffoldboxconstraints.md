---
title: "Class: ScaffoldBoxConstraints"
description: "Box constraints with additional header and footer height information."
---

```dart
/// Box constraints with additional header and footer height information.
///
/// Extends [BoxConstraints] to include scaffold-specific layout measurements.
class ScaffoldBoxConstraints extends BoxConstraints {
  /// Height of the header section.
  final double headerHeight;
  /// Height of the footer section.
  final double footerHeight;
  /// Creates [ScaffoldBoxConstraints].
  ///
  /// Parameters:
  /// - [headerHeight] (`double`, required): Header height.
  /// - [footerHeight] (`double`, required): Footer height.
  /// - Additional [BoxConstraints] parameters.
  const ScaffoldBoxConstraints({required this.headerHeight, required this.footerHeight, super.minWidth, super.maxWidth, super.minHeight, super.maxHeight});
  /// Creates [ScaffoldBoxConstraints] from existing [BoxConstraints].
  ///
  /// Parameters:
  /// - [constraints] (`BoxConstraints`, required): Base constraints.
  /// - [headerHeight] (`double`, required): Header height.
  /// - [footerHeight] (`double`, required): Footer height.
  ///
  /// Returns: New [ScaffoldBoxConstraints] with scaffold-specific data.
  factory ScaffoldBoxConstraints.fromBoxConstraints({required BoxConstraints constraints, required double headerHeight, required double footerHeight});
  ScaffoldBoxConstraints copyWith({double? headerHeight, double? footerHeight, double? minWidth, double? maxWidth, double? minHeight, double? maxHeight});
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
