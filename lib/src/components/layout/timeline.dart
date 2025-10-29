import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Theme configuration for [Timeline] widgets.
///
/// Provides styling and layout defaults for timeline components including
/// column constraints, spacing, indicator appearance, and connector styling.
/// Used with [ComponentTheme] to apply consistent timeline styling across
/// an application while allowing per-instance customization.
///
/// Example:
/// ```dart
/// ComponentTheme<TimelineTheme>(
///   data: TimelineTheme(
///     timeConstraints: BoxConstraints(minWidth: 100, maxWidth: 150),
///     spacing: 20.0,
///     dotSize: 16.0,
///     color: Colors.blue,
///     rowGap: 24.0,
///   ),
///   child: MyTimelineWidget(),
/// );
/// ```
class TimelineTheme {
  /// Default constraints for the time column width.
  ///
  /// Controls the minimum and maximum width allocated for displaying time
  /// information in each timeline row. If null, individual Timeline widgets
  /// use their own constraints or a default of 120 logical pixels.
  final BoxConstraints? timeConstraints;

  /// Default horizontal spacing between timeline columns.
  ///
  /// Determines the gap between the time column, indicator column, and content
  /// column. If null, defaults to 16 logical pixels scaled by theme scaling factor.
  final double? spacing;

  /// Default diameter of timeline indicator dots.
  ///
  /// Controls the size of the circular (or square, based on theme radius) indicator
  /// that marks each timeline entry. If null, defaults to 12 logical pixels.
  final double? dotSize;

  /// Default thickness of connector lines between timeline entries.
  ///
  /// Controls the width of vertical lines that connect timeline indicators.
  /// If null, defaults to 2 logical pixels scaled by theme scaling factor.
  final double? connectorThickness;

  /// Default color for indicators and connectors when not specified per entry.
  ///
  /// Used as the fallback color for timeline dots and connecting lines when
  /// individual [TimelineData] entries don't specify their own color.
  final Color? color;

  /// Default vertical spacing between timeline rows.
  ///
  /// Controls the gap between each timeline entry in the vertical layout.
  /// If null, defaults to 16 logical pixels scaled by theme scaling factor.
  final double? rowGap;

  /// Creates a [TimelineTheme] with the specified styling options.
  ///
  /// All parameters are optional and will be merged with widget-level settings
  /// or system defaults when not specified.
  ///
  /// Parameters:
  /// - [timeConstraints] (BoxConstraints?, optional): Width constraints for time column.
  /// - [spacing] (double?, optional): Horizontal spacing between columns.
  /// - [dotSize] (double?, optional): Size of timeline indicator dots.
  /// - [connectorThickness] (double?, optional): Thickness of connecting lines.
  /// - [color] (Color?, optional): Default color for indicators and connectors.
  /// - [rowGap] (double?, optional): Vertical spacing between timeline entries.
  const TimelineTheme({
    this.timeConstraints,
    this.spacing,
    this.dotSize,
    this.connectorThickness,
    this.color,
    this.rowGap,
  });

  /// Creates a copy of this theme with the given values replaced.
  ///
  /// Uses [ValueGetter] functions to allow conditional updates where
  /// null getters preserve the original value.
  ///
  /// Example:
  /// ```dart
  /// final newTheme = originalTheme.copyWith(
  ///   spacing: () => 24.0,
  ///   color: () => Colors.green,
  /// );
  /// ```
  TimelineTheme copyWith({
    ValueGetter<BoxConstraints?>? timeConstraints,
    ValueGetter<double?>? spacing,
    ValueGetter<double?>? dotSize,
    ValueGetter<double?>? connectorThickness,
    ValueGetter<Color?>? color,
    ValueGetter<double?>? rowGap,
  }) {
    return TimelineTheme(
      timeConstraints:
          timeConstraints == null ? this.timeConstraints : timeConstraints(),
      spacing: spacing == null ? this.spacing : spacing(),
      dotSize: dotSize == null ? this.dotSize : dotSize(),
      connectorThickness: connectorThickness == null
          ? this.connectorThickness
          : connectorThickness(),
      color: color == null ? this.color : color(),
      rowGap: rowGap == null ? this.rowGap : rowGap(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TimelineTheme &&
        other.timeConstraints == timeConstraints &&
        other.spacing == spacing &&
        other.dotSize == dotSize &&
        other.connectorThickness == connectorThickness &&
        other.color == color &&
        other.rowGap == rowGap;
  }

  @override
  int get hashCode => Object.hash(
      timeConstraints, spacing, dotSize, connectorThickness, color, rowGap);
}

/// Data model for individual timeline entries.
///
/// Represents a single item in a timeline with time information, title,
/// optional content, and optional custom color for the indicator and connector.
/// Used by [Timeline] to construct the visual timeline representation.
///
/// Example:
/// ```dart
/// TimelineData(
///   time: Text('2:30 PM'),
///   title: Text('Meeting Started'),
///   content: Text('Weekly team sync began with all members present.'),
///   color: Colors.green,
/// );
/// ```
class TimelineData {
  /// Widget displaying the time or timestamp for this timeline entry.
  ///
  /// Positioned in the left column of the timeline with right alignment.
  /// Typically contains time information, dates, or sequence numbers.
  final Widget time;

  /// Widget displaying the main title or heading for this timeline entry.
  ///
  /// Positioned in the right column as the primary content identifier.
  /// Usually contains the event name, milestone title, or key description.
  final Widget title;

  /// Optional widget with additional details about this timeline entry.
  ///
  /// Positioned below the title in the right column when provided.
  /// Can contain descriptions, additional context, or supporting information.
  final Widget? content;

  /// Optional custom color for this entry's indicator and connector.
  ///
  /// When provided, overrides the default theme color for this specific
  /// timeline entry. If null, uses the theme's default color.
  final Color? color;

  /// Creates a [TimelineData] entry for use in [Timeline] widgets.
  ///
  /// Parameters:
  /// - [time] (Widget, required): Time or timestamp display widget.
  /// - [title] (Widget, required): Main title or heading widget.
  /// - [content] (Widget?, optional): Additional details widget.
  /// - [color] (Color?, optional): Custom color for indicator and connector.
  ///
  /// Example:
  /// ```dart
  /// TimelineData(
  ///   time: Text('10:00 AM', style: TextStyle(fontWeight: FontWeight.bold)),
  ///   title: Text('Project Kickoff'),
  ///   content: Text('Initial meeting to discuss project scope and timeline.'),
  ///   color: Colors.blue,
  /// );
  /// ```
  TimelineData({
    required this.time,
    required this.title,
    this.content,
    this.color,
  });
}

/// A vertical timeline widget for displaying chronological data.
///
/// [Timeline] creates a structured vertical layout showing a sequence of events
/// or data points with time information, titles, optional content, and visual
/// indicators. Each entry is represented by a [TimelineData] object and displayed
/// with a consistent three-column layout:
///
/// 1. Left column: Time/timestamp information (right-aligned)
/// 2. Center column: Visual indicator dot and connecting lines
/// 3. Right column: Title and optional content
///
/// The timeline automatically handles:
/// - Proper spacing and alignment between columns
/// - Visual indicators with customizable colors per entry
/// - Connecting lines between entries (except for the last entry)
/// - Responsive sizing based on theme scaling
/// - Text styling consistent with the design system
///
/// Supports theming via [TimelineTheme] for consistent styling and can be
/// customized per instance with the [timeConstraints] parameter.
///
/// Example:
/// ```dart
/// Timeline(
///   data: [
///     TimelineData(
///       time: Text('9:00 AM'),
///       title: Text('Morning Standup'),
///       content: Text('Daily team sync to discuss progress and blockers.'),
///       color: Colors.green,
///     ),
///     TimelineData(
///       time: Text('2:00 PM'),
///       title: Text('Code Review'),
///       content: Text('Review pull requests and provide feedback.'),
///     ),
///   ],
/// );
/// ```
class Timeline extends StatelessWidget {
  /// List of timeline entries to display.
  ///
  /// Each [TimelineData] object represents one row in the timeline with
  /// time information, title, optional content, and optional custom color.
  /// The timeline renders entries in the order provided in this list.
  final List<TimelineData> data;

  /// Override constraints for the time column width.
  ///
  /// When provided, overrides the theme's [TimelineTheme.timeConstraints]
  /// for this specific timeline instance. Controls how much space is allocated
  /// for displaying time information. If null, uses theme or default constraints.
  final BoxConstraints? timeConstraints;

  /// Creates a [Timeline] widget with the specified data entries.
  ///
  /// Parameters:
  /// - [data] (`List<TimelineData>`, required): Timeline entries to display in order.
  /// - [timeConstraints] (BoxConstraints?, optional): Override width constraints for time column.
  ///
  /// The timeline automatically handles layout, styling, and visual indicators
  /// based on the current theme and provided data. Each entry's time, title,
  /// content, and color are used to construct the appropriate visual representation.
  ///
  /// Example:
  /// ```dart
  /// Timeline(
  ///   timeConstraints: BoxConstraints(minWidth: 80, maxWidth: 120),
  ///   data: [
  ///     TimelineData(
  ///       time: Text('Yesterday'),
  ///       title: Text('Initial Setup'),
  ///       content: Text('Project repository created and initial structure added.'),
  ///     ),
  ///     TimelineData(
  ///       time: Text('Today'),
  ///       title: Text('Feature Development'),
  ///       content: Text('Implementing core functionality and UI components.'),
  ///       color: Colors.orange,
  ///     ),
  ///   ],
  /// );
  /// ```
  const Timeline({
    super.key,
    required this.data,
    // this.timeConstraints = const BoxConstraints(
    //   minWidth: 120,
    //   maxWidth: 120,
    // ),
    this.timeConstraints,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final compTheme = ComponentTheme.maybeOf<TimelineTheme>(context);
    final timeConstraints = this.timeConstraints ??
        compTheme?.timeConstraints ??
        BoxConstraints(minWidth: 120 * scaling, maxWidth: 120 * scaling);
    final spacing = compTheme?.spacing ?? 16 * scaling;
    final dotSize = compTheme?.dotSize ?? 12 * scaling;
    final connectorThickness = compTheme?.connectorThickness ?? 2 * scaling;
    final defaultColor = compTheme?.color ?? theme.colorScheme.primary;
    final rowGap = compTheme?.rowGap ?? 16 * scaling;
    List<Widget> rows = [];
    for (int i = 0; i < data.length; i++) {
      final data = this.data[i];
      rows.add(IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ConstrainedBox(
              constraints: timeConstraints,
              child: Align(
                alignment: Alignment.topRight,
                child: data.time.medium().small(),
              ),
            ),
            Gap(spacing),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 4 * scaling),
                  width: dotSize,
                  height: dotSize,
                  decoration: BoxDecoration(
                    shape: theme.radius == 0
                        ? BoxShape.rectangle
                        : BoxShape.circle,
                    color: data.color ?? defaultColor,
                  ),
                ),
                if (i != this.data.length - 1)
                  Expanded(
                    child: VerticalDivider(
                      thickness: connectorThickness,
                      color: data.color ?? defaultColor,
                      endIndent: (-4 - spacing) * scaling,
                    ),
                  ),
              ],
            ),
            Gap(spacing),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  data.title
                      .semiBold()
                      .secondaryForeground()
                      .base()
                      .withPadding(left: 4 * scaling),
                  if (data.content != null) Gap(8 * scaling),
                  if (data.content != null)
                    Expanded(child: data.content!.muted().small()),
                ],
              ),
            )
          ],
        ),
      ));
    }
    return Column(
      children: rows,
    ).gap(rowGap);
  }
}
