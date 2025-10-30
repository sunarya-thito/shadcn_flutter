---
title: "Class: Tracker"
description: "A widget that displays a tracker."
---

```dart
/// A widget that displays a tracker.
///
/// This widget displays a row of tracker levels with tooltips.
/// The row contains a tracker level for each tracker in the [data] list.
/// A horizontal status tracking widget with interactive tooltips.
///
/// [Tracker] provides a visual representation of status data as colored segments
/// in a horizontal layout. Each segment represents a data point with an associated
/// status level and interactive tooltip. It's commonly used for monitoring
/// dashboards, progress indicators, and status overviews.
///
/// ## Key Features
/// - **Status Visualization**: Color-coded segments based on [TrackerLevel]
/// - **Interactive Tooltips**: Hover-activated tooltips with custom content
/// - **Flexible Sizing**: Segments automatically expand to fill available width
/// - **Theming**: Comprehensive styling via [TrackerTheme]
/// - **Rounded Corners**: Configurable corner radius for modern appearance
///
/// ## Layout Behavior
/// The tracker displays segments as equally-sized horizontal sections that
/// expand to fill the available width. Gaps between segments and overall
/// styling can be controlled through the theme system.
///
/// ## Use Cases
/// - Server status monitoring (healthy, warning, critical states)
/// - Progress tracking across multiple stages
/// - Resource utilization indicators
/// - Quality metrics visualization
/// - Timeline status representation
///
/// Example:
/// ```dart
/// Tracker(
///   data: [
///     TrackerData(
///       level: TrackerLevel.fine,
///       tooltip: Text('Database: Healthy\n95% uptime'),
///     ),
///     TrackerData(
///       level: TrackerLevel.warning,
///       tooltip: Text('API: Warning\nHigh response time'),
///     ),
///     TrackerData(
///       level: TrackerLevel.critical,
///       tooltip: Text('Cache: Critical\nMemory usage: 98%'),
///     ),
///   ],
/// );
/// ```
class Tracker extends StatelessWidget {
  /// List of data points to display as tracker segments.
  ///
  /// Type: `List<TrackerData>`. Each data point contains a status level
  /// for visual styling and tooltip content for user interaction. The
  /// segments are displayed in the order provided, each taking equal
  /// horizontal space.
  final List<TrackerData> data;
  /// Creates a [Tracker] widget.
  ///
  /// Displays status data as interactive, color-coded horizontal segments
  /// with hover tooltips for additional context.
  ///
  /// Parameters:
  /// - [data] (`List<TrackerData>`, required): Status data points to display
  ///
  /// Example:
  /// ```dart
  /// Tracker(
  ///   data: [
  ///     TrackerData(
  ///       level: TrackerLevel.fine,
  ///       tooltip: Text('System OK'),
  ///     ),
  ///     TrackerData(
  ///       level: TrackerLevel.warning,
  ///       tooltip: Text('Minor Issues'),
  ///     ),
  ///   ],
  /// );
  /// ```
  const Tracker({super.key, required this.data});
  Widget build(BuildContext context);
}
```
