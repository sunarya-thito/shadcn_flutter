---
title: "Class: Timeline"
description: "A vertical timeline widget for displaying chronological data."
---

```dart
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
  const Timeline({super.key, required this.data, this.timeConstraints});
  Widget build(BuildContext context);
}
```
