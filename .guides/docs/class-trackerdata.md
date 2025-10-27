---
title: "Class: TrackerData"
description: "A data container for individual tracker segments."
---

```dart
/// A data container for individual tracker segments.
///
/// [TrackerData] encapsulates the information needed to display a single
/// segment within a [Tracker] widget. Each segment represents a data point
/// with an associated status level and contextual information.
///
/// ## Components
/// - **Tooltip**: Interactive content displayed on hover for additional context
/// - **Level**: Status level determining the visual appearance and meaning
///
/// ## Usage
/// Tracker data is typically created from application data models and
/// transformed into visual representations for status monitoring dashboards,
/// progress indicators, or health monitoring interfaces.
///
/// Example:
/// ```dart
/// TrackerData(
///   level: TrackerLevel.warning,
///   tooltip: Column(
///     mainAxisSize: MainAxisSize.min,
///     children: [
///       Text('Server Load'),
///       Text('75% - Warning Level'),
///       Text('Last Updated: 2 min ago'),
///     ],
///   ),
/// );
/// ```
class TrackerData {
  /// The tooltip content displayed on hover.
  ///
  /// Type: `Widget`. Interactive content shown when the user hovers over
  /// this tracker segment. Can contain text, icons, or complex layouts
  /// providing additional context about the data point.
  final Widget tooltip;
  /// The status level determining visual appearance.
  ///
  /// Type: `TrackerLevel`. Defines the color and semantic meaning of this
  /// tracker segment. Used to determine the background color and accessibility
  /// information for the segment.
  final TrackerLevel level;
  /// Creates a new [TrackerData] instance.
  ///
  /// Combines a tooltip for user interaction with a status level for
  /// visual representation in tracker components.
  ///
  /// Parameters:
  /// - [tooltip] (Widget, required): Interactive content for hover display
  /// - [level] (TrackerLevel, required): Status level for visual styling
  ///
  /// Example:
  /// ```dart
  /// TrackerData(
  ///   tooltip: Text('CPU Usage: 45%'),
  ///   level: TrackerLevel.fine,
  /// );
  /// ```
  const TrackerData({required this.tooltip, required this.level});
}
```
