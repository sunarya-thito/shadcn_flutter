---
title: "Class: TimelineData"
description: "Data model for individual timeline entries."
---

```dart
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
  TimelineData({required this.time, required this.title, this.content, this.color});
}
```
