---
title: "Class: SingleChartColorScheme"
description: "A chart color scheme that uses a single color for all chart elements."
---

```dart
/// A chart color scheme that uses a single color for all chart elements.
class SingleChartColorScheme implements ChartColorScheme {
  /// The single color used for all chart elements.
  final Color color;
  /// Creates a single color chart scheme.
  const SingleChartColorScheme(this.color);
  List<Color> get chartColors;
  Color get chart1;
  Color get chart2;
  Color get chart3;
  Color get chart4;
  Color get chart5;
}
```
