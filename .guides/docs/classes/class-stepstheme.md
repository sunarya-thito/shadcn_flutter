---
title: "Class: StepsTheme"
description: "Theme for [Steps]."
---

```dart
/// Theme for [Steps].
class StepsTheme {
  /// Diameter of the step indicator circle.
  final double? indicatorSize;
  /// Gap between the indicator and the step content.
  final double? spacing;
  /// Color of the indicator and connector line.
  final Color? indicatorColor;
  /// Thickness of the connector line.
  final double? connectorThickness;
  /// Creates a [StepsTheme].
  const StepsTheme({this.indicatorSize, this.spacing, this.indicatorColor, this.connectorThickness});
  /// Creates a copy of this theme with the given fields replaced.
  StepsTheme copyWith({ValueGetter<double?>? indicatorSize, ValueGetter<double?>? spacing, ValueGetter<Color?>? indicatorColor, ValueGetter<double?>? connectorThickness});
  bool operator ==(Object other);
  int get hashCode;
}
```
