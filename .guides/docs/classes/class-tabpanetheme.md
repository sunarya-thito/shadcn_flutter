---
title: "Class: TabPaneTheme"
description: "Theme configuration for [TabPane] appearance and layout."
---

```dart
/// Theme configuration for [TabPane] appearance and layout.
///
/// TabPaneTheme defines the visual styling for tab pane components including
/// borders, background colors, dimensions, and corner rounding. All properties
/// are optional and fall back to theme defaults when not specified.
///
/// Example:
/// ```dart
/// ComponentTheme<TabPaneTheme>(
///   data: TabPaneTheme(
///     borderRadius: BorderRadius.circular(12),
///     backgroundColor: Colors.white,
///     border: BorderSide(color: Colors.grey),
///     barHeight: 40.0,
///   ),
///   child: TabPane(...),
/// )
/// ```
/// Theme for [TabPane].
class TabPaneTheme {
  /// Border radius for the tab pane container and individual tabs.
  ///
  /// Type: `BorderRadiusGeometry?`. If null, uses the theme's large border radius.
  /// This affects both the main content area and the tab button appearance.
  final BorderRadiusGeometry? borderRadius;
  /// Background color for the tab pane content area and active tabs.
  ///
  /// Type: `Color?`. If null, uses the theme's card color. This provides
  /// the background for both the main content area and highlighted tabs.
  final Color? backgroundColor;
  /// Border styling for the tab pane container.
  ///
  /// Type: `BorderSide?`. If null, uses the theme's default border. This
  /// creates the outline around the entire tab pane component.
  final BorderSide? border;
  /// Height of the tab bar area in logical pixels.
  ///
  /// Type: `double?`. If null, uses 32 logical pixels scaled by theme scaling.
  /// This determines the vertical space allocated for the tab buttons.
  final double? barHeight;
  /// Creates a [TabPaneTheme].
  ///
  /// All parameters are optional and allow customization of tab pane appearance.
  ///
  /// Parameters:
  /// - [borderRadius] (`BorderRadiusGeometry?`, optional): Border radius for the tab pane container.
  /// - [backgroundColor] (`Color?`, optional): Background color of the tab pane.
  /// - [border] (`BorderSide?`, optional): Border styling for the tab pane.
  /// - [barHeight] (`double?`, optional): Height of the tab bar area.
  ///
  /// Example:
  /// ```dart
  /// const TabPaneTheme(
  ///   borderRadius: BorderRadius.circular(8),
  ///   backgroundColor: Colors.white,
  ///   border: BorderSide(color: Colors.grey),
  ///   barHeight: 32.0,
  /// )
  /// ```
  const TabPaneTheme({this.borderRadius, this.backgroundColor, this.border, this.barHeight});
  /// Creates a copy with specified fields replaced.
  ///
  /// Parameters:
  /// - [borderRadius] (`ValueGetter<BorderRadiusGeometry?>?`, optional): new border radius getter
  /// - [backgroundColor] (`ValueGetter<Color?>?`, optional): new background color getter
  /// - [border] (`ValueGetter<BorderSide?>?`, optional): new border getter
  /// - [barHeight] (`ValueGetter<double?>?`, optional): new bar height getter
  ///
  /// Returns: `TabPaneTheme` — new theme with updated values
  TabPaneTheme copyWith({ValueGetter<BorderRadiusGeometry?>? borderRadius, ValueGetter<Color?>? backgroundColor, ValueGetter<BorderSide?>? border, ValueGetter<double?>? barHeight});
  bool operator ==(Object other);
  int get hashCode;
}
```
