---
title: "Class: DrawerTheme"
description: "Theme configuration for drawer and sheet overlays."
---

```dart
/// Theme configuration for drawer and sheet overlays.
///
/// Defines visual properties for drawer and sheet components including
/// surface effects, drag handles, and barrier appearance.
///
/// Features:
/// - Surface opacity and blur effects
/// - Customizable barrier colors
/// - Drag handle appearance control
/// - Consistent theming across drawer types
///
/// Example:
/// ```dart
/// ComponentThemeData(
///   data: {
///     DrawerTheme: DrawerTheme(
///       surfaceOpacity: 0.9,
///       barrierColor: Colors.black54,
///       showDragHandle: true,
///     ),
///   },
///   child: MyApp(),
/// )
/// ```
class DrawerTheme {
  /// Surface opacity for backdrop effects.
  final double? surfaceOpacity;
  /// Surface blur intensity for backdrop effects.
  final double? surfaceBlur;
  /// Color of the barrier behind the drawer.
  final Color? barrierColor;
  /// Whether to display the drag handle for draggable drawers.
  final bool? showDragHandle;
  /// Size of the drag handle when displayed.
  final Size? dragHandleSize;
  /// Creates a [DrawerTheme].
  ///
  /// All parameters are optional and will use system defaults when null.
  ///
  /// Parameters:
  /// - [surfaceOpacity] (double?, optional): opacity for backdrop surface effects
  /// - [surfaceBlur] (double?, optional): blur intensity for backdrop effects
  /// - [barrierColor] (Color?, optional): color of the modal barrier
  /// - [showDragHandle] (bool?, optional): whether to show drag handles
  /// - [dragHandleSize] (Size?, optional): size of the drag handle
  ///
  /// Example:
  /// ```dart
  /// const DrawerTheme(
  ///   surfaceOpacity: 0.95,
  ///   showDragHandle: true,
  ///   barrierColor: Color.fromRGBO(0, 0, 0, 0.7),
  /// )
  /// ```
  const DrawerTheme({this.surfaceOpacity, this.surfaceBlur, this.barrierColor, this.showDragHandle, this.dragHandleSize});
  /// Creates a copy of this theme with the given fields replaced.
  ///
  /// Parameters:
  /// - [surfaceOpacity] (`ValueGetter<double?>?`, optional): New surface opacity.
  /// - [surfaceBlur] (`ValueGetter<double?>?`, optional): New surface blur amount.
  /// - [barrierColor] (`ValueGetter<Color?>?`, optional): New barrier color.
  /// - [showDragHandle] (`ValueGetter<bool?>?`, optional): New show drag handle setting.
  /// - [dragHandleSize] (`ValueGetter<Size?>?`, optional): New drag handle size.
  ///
  /// Returns: A new [DrawerTheme] with updated properties.
  DrawerTheme copyWith({ValueGetter<double?>? surfaceOpacity, ValueGetter<double?>? surfaceBlur, ValueGetter<Color?>? barrierColor, ValueGetter<bool?>? showDragHandle, ValueGetter<Size?>? dragHandleSize});
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
