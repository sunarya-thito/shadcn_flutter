import 'package:shadcn_flutter/shadcn_flutter.dart';

/// An abstract class that defines values for different Tracker levels.
///
/// [TrackerLevel] provides a standardized way to represent different status
/// or priority levels in tracker components. Each level defines both a visual
/// color and descriptive name for consistent representation across the UI.
///
/// ## Predefined Levels
/// The class includes several predefined levels for common use cases:
/// - [fine]: Green color, typically for healthy/good states
/// - [warning]: Orange color, for cautionary states requiring attention
/// - [critical]: Red color, for urgent states requiring immediate action
/// - [unknown]: Gray color, for undefined or unavailable states
///
/// ## Custom Levels
/// Custom tracker levels can be implemented by extending this abstract class
/// and providing [color] and [name] implementations.
///
/// Example:
/// ```dart
/// // Using predefined levels
/// TrackerData(
///   level: TrackerLevel.critical,
///   tooltip: Text('System Alert'),
/// );
///
/// // Creating custom level
/// class CustomLevel implements TrackerLevel {
///   @override
///   Color get color => Colors.purple;
///
///   @override
///   String get name => 'Custom';
/// }
/// ```
abstract class TrackerLevel {
  /// Default values for the fine level.
  ///
  /// [color] is set to `Colors.green`
  /// [name] is set to `"Fine"`
  static const TrackerLevel fine = _SimpleTrackerLevel(Colors.green, 'Fine');

  /// Default values for the warning level.
  ///
  /// [color] is set to `Colors.orange`
  /// [name] is set to `"Warning"`
  static const TrackerLevel warning =
      _SimpleTrackerLevel(Colors.orange, 'Warning');

  /// Default values for the critical level.
  ///
  /// [color] is set to `Colors.red`
  /// [name] is set to `"Critical"`
  static const TrackerLevel critical =
      _SimpleTrackerLevel(Colors.red, 'Critical');

  /// Default values for the unknown level.
  ///
  /// [color] is set to `Colors.gray`
  /// [name] is set to `"Unknown"`
  static const TrackerLevel unknown =
      _SimpleTrackerLevel(Colors.gray, 'Unknown');

  /// Gets the color for the specified [TrackerLevel].
  ///
  /// Returns the [Color] associated with this tracker level, used for
  /// visual representation in the tracker component.
  Color get color;

  /// Gets the name for the specified [TrackerLevel].
  ///
  /// Returns a [String] description of this tracker level, typically
  /// used in tooltips or accessibility labels.
  String get name;
}

class _SimpleTrackerLevel implements TrackerLevel {
  @override
  final Color color;

  @override
  final String name;

  const _SimpleTrackerLevel(this.color, this.name);
}

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
  const TrackerData({
    required this.tooltip,
    required this.level,
  });
}

/// Theme configuration for [Tracker] components.
///
/// [TrackerTheme] provides styling options for tracker components including
/// corner radius, spacing between segments, and segment height. It enables
/// consistent tracker styling across an application while allowing customization.
///
/// Used with [ComponentTheme] to apply theme values throughout the widget tree.
///
/// Example:
/// ```dart
/// ComponentTheme<TrackerTheme>(
///   data: TrackerTheme(
///     radius: 8.0,
///     gap: 2.0,
///     itemHeight: 40.0,
///   ),
///   child: MyTrackerWidget(),
/// );
/// ```
class TrackerTheme {
  /// Corner radius for the tracker container in logical pixels.
  ///
  /// Type: `double?`. Controls the rounding of tracker corners. If null,
  /// defaults to theme.radiusMd for consistent corner styling.
  final double? radius;

  /// Gap between individual tracker segments in logical pixels.
  ///
  /// Type: `double?`. Spacing between adjacent tracker segments. If null,
  /// defaults to theme.scaling * 2 for proportional spacing.
  final double? gap;

  /// Height of individual tracker segments in logical pixels.
  ///
  /// Type: `double?`. Controls the vertical size of tracker segments.
  /// If null, defaults to 32 logical pixels.
  final double? itemHeight;

  /// Creates a [TrackerTheme].
  ///
  /// All parameters are optional and will fall back to theme defaults
  /// when not provided.
  ///
  /// Parameters:
  /// - [radius] (double?, optional): Corner radius in pixels
  /// - [gap] (double?, optional): Spacing between segments in pixels
  /// - [itemHeight] (double?, optional): Height of segments in pixels
  ///
  /// Example:
  /// ```dart
  /// TrackerTheme(
  ///   radius: 12.0,
  ///   gap: 4.0,
  ///   itemHeight: 48.0,
  /// );
  /// ```
  const TrackerTheme({
    this.radius,
    this.gap,
    this.itemHeight,
  });

  /// Creates a copy of this theme with the given values replaced.
  ///
  /// Returns a new [TrackerTheme] instance with the same values as this
  /// theme, except for any parameters that are explicitly provided. Use
  /// [ValueGetter] functions to specify new values.
  ///
  /// Example:
  /// ```dart
  /// final newTheme = originalTheme.copyWith(
  ///   radius: () => 16.0,
  ///   itemHeight: () => 56.0,
  /// );
  /// ```
  TrackerTheme copyWith({
    ValueGetter<double?>? radius,
    ValueGetter<double?>? gap,
    ValueGetter<double?>? itemHeight,
  }) {
    return TrackerTheme(
      radius: radius == null ? this.radius : radius(),
      gap: gap == null ? this.gap : gap(),
      itemHeight: itemHeight == null ? this.itemHeight : itemHeight(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TrackerTheme &&
        other.radius == radius &&
        other.gap == gap &&
        other.itemHeight == itemHeight;
  }

  @override
  int get hashCode => Object.hash(
        radius,
        gap,
        itemHeight,
      );

  @override
  String toString() =>
      'TrackerTheme(radius: $radius, gap: $gap, itemHeight: $itemHeight)';
}

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
  const Tracker({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final trackerTheme = ComponentTheme.maybeOf<TrackerTheme>(context);
    return ClipRRect(
      borderRadius:
          BorderRadius.circular(trackerTheme?.radius ?? theme.radiusMd),
      child: Row(
        children: [
          for (final data in this.data)
            Expanded(
              child: InstantTooltip(
                tooltipBuilder: (context) {
                  return TooltipContainer(
                    child: data.tooltip,
                  );
                },
                child: Container(
                  height: trackerTheme?.itemHeight ?? 32,
                  color: data.level.color,
                ),
              ),
            )
        ],
      ).gap(trackerTheme?.gap ?? theme.scaling * 2),
    );
  }
}
