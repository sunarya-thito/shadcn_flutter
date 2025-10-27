---
title: "Class: TabListTheme"
description: "Theme configuration for [TabList] appearance and behavior."
---

```dart
/// Theme configuration for [TabList] appearance and behavior.
///
/// TabListTheme defines the visual styling for tab list components including
/// border colors, indicator styling, and dimensional properties. All properties
/// are optional and fall back to theme defaults when not specified.
///
/// Example:
/// ```dart
/// ComponentTheme<TabListTheme>(
///   data: TabListTheme(
///     borderColor: Colors.grey,
///     borderWidth: 2.0,
///     indicatorColor: Colors.blue,
///     indicatorHeight: 3.0,
///   ),
///   child: TabList(...),
/// )
/// ```
class TabListTheme {
  /// Color of the bottom border line separating tabs from content.
  ///
  /// Type: `Color?`. If null, uses the theme's border color. This creates
  /// visual separation between the tab bar and the content area.
  final Color? borderColor;
  /// Width of the bottom border line in logical pixels.
  ///
  /// Type: `double?`. If null, uses 1 logical pixel scaled by theme scaling.
  /// The border provides structure and visual hierarchy to the tab interface.
  final double? borderWidth;
  /// Color of the active tab indicator line.
  ///
  /// Type: `Color?`. If null, uses the theme's primary color. The indicator
  /// clearly shows which tab is currently active.
  final Color? indicatorColor;
  /// Height of the active tab indicator line in logical pixels.
  ///
  /// Type: `double?`. If null, uses 2 logical pixels scaled by theme scaling.
  /// The indicator appears at the bottom of the active tab.
  final double? indicatorHeight;
  const TabListTheme({this.borderColor, this.borderWidth, this.indicatorColor, this.indicatorHeight});
  TabListTheme copyWith({ValueGetter<Color?>? borderColor, ValueGetter<double?>? borderWidth, ValueGetter<Color?>? indicatorColor, ValueGetter<double?>? indicatorHeight});
  bool operator ==(Object other);
  int get hashCode;
}
```
