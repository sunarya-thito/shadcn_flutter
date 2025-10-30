---
title: "Class: ChartColorScheme"
description: "A color scheme for charts with 5 distinct colors."
---

```dart
/// A color scheme for charts with 5 distinct colors.
///
/// Provides colors for up to 5 different data series in charts.
class ChartColorScheme {
  /// The list of chart colors.
  final List<Color> chartColors;
  /// Creates a chart color scheme with the given colors.
  const ChartColorScheme(this.chartColors);
  /// Creates a chart color scheme using a single color for all elements.
  factory ChartColorScheme.single(Color color);
  /// Color for the first chart series.
  Color get chart1;
  /// Color for the second chart series.
  Color get chart2;
  /// Color for the third chart series.
  Color get chart3;
  /// Color for the fourth chart series.
  Color get chart4;
  /// Color for the fifth chart series.
  Color get chart5;
}
```
