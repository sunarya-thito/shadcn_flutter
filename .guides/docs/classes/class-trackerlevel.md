---
title: "Class: TrackerLevel"
description: "An abstract class that defines values for different Tracker levels."
---

```dart
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
  static const TrackerLevel warning = _SimpleTrackerLevel(Colors.orange, 'Warning');
  /// Default values for the critical level.
  ///
  /// [color] is set to `Colors.red`
  /// [name] is set to `"Critical"`
  static const TrackerLevel critical = _SimpleTrackerLevel(Colors.red, 'Critical');
  /// Default values for the unknown level.
  ///
  /// [color] is set to `Colors.gray`
  /// [name] is set to `"Unknown"`
  static const TrackerLevel unknown = _SimpleTrackerLevel(Colors.gray, 'Unknown');
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
```
