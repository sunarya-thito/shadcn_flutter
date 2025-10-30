---
title: "Extension: WidgetExtension"
description: "Extension adding layout and styling utilities to widgets."
---

```dart
/// Extension adding layout and styling utilities to widgets.
extension WidgetExtension on Widget {
  /// Converts this widget to a builder function.
  ///
  /// Returns a [NeverWidgetBuilder] that ignores all parameters and returns this widget.
  NeverWidgetBuilder get asBuilder;
  /// Wraps this widget in a [SizedBox] with specified dimensions.
  ///
  /// If this widget is already a [SizedBox], merges the dimensions.
  ///
  /// Parameters:
  /// - [width] (`double?`, optional): Desired width.
  /// - [height] (`double?`, optional): Desired height.
  ///
  /// Returns: `Widget` — sized widget.
  Widget sized({double? width, double? height});
  /// Wraps this widget in a [ConstrainedBox] with specified constraints.
  ///
  /// If this widget is already a [ConstrainedBox], merges the constraints.
  ///
  /// Parameters:
  /// - [minWidth] (`double?`, optional): Minimum width.
  /// - [maxWidth] (`double?`, optional): Maximum width.
  /// - [minHeight] (`double?`, optional): Minimum height.
  /// - [maxHeight] (`double?`, optional): Maximum height.
  /// - [width] (`double?`, optional): Fixed width (sets both min and max).
  /// - [height] (`double?`, optional): Fixed height (sets both min and max).
  ///
  /// Returns: `Widget` — constrained widget.
  Widget constrained({double? minWidth, double? maxWidth, double? minHeight, double? maxHeight, double? width, double? height});
  /// Wraps this widget in a [Padding] widget.
  ///
  /// Provides flexible padding specification via individual edges,
  /// combined directions, or uniform padding.
  ///
  /// Parameters:
  /// - [top] (`double?`, optional): Top padding.
  /// - [bottom] (`double?`, optional): Bottom padding.
  /// - [left] (`double?`, optional): Left padding.
  /// - [right] (`double?`, optional): Right padding.
  /// - [horizontal] (`double?`, optional): Left and right padding (cannot use with left/right).
  /// - [vertical] (`double?`, optional): Top and bottom padding (cannot use with top/bottom).
  /// - [all] (`double?`, optional): Uniform padding on all sides (cannot use with others).
  /// - [padding] (`EdgeInsetsGeometry?`, optional): Direct padding value (overrides all other params).
  ///
  /// Returns: `Widget` — padded widget.
  ///
  /// Throws [FlutterError] if conflicting parameters are used.
  Widget withPadding({double? top, double? bottom, double? left, double? right, double? horizontal, double? vertical, double? all, EdgeInsetsGeometry? padding});
  /// Centers this widget horizontally and vertically.
  ///
  /// Parameters:
  /// - [key] (`Key?`, optional): Widget key.
  ///
  /// Returns: `Widget` — centered widget.
  Widget center({Key? key});
  /// Aligns this widget within its parent.
  ///
  /// Parameters:
  /// - [alignment] (`AlignmentGeometry`, required): Alignment position.
  ///
  /// Returns: `Widget` — aligned widget.
  Widget withAlign(AlignmentGeometry alignment);
  /// Positions this widget absolutely within a [Stack].
  ///
  /// Parameters:
  /// - [key] (`Key?`, optional): Widget key.
  /// - [left] (`double?`, optional): Left offset.
  /// - [top] (`double?`, optional): Top offset.
  /// - [right] (`double?`, optional): Right offset.
  /// - [bottom] (`double?`, optional): Bottom offset.
  ///
  /// Returns: `Widget` — positioned widget.
  Widget positioned({Key? key, double? left, double? top, double? right, double? bottom});
  /// Makes this widget expanded within a [Flex] parent (Row/Column).
  ///
  /// Parameters:
  /// - [flex] (`int`, default: 1): Flex factor for space distribution.
  ///
  /// Returns: `Widget` — expanded widget.
  Widget expanded({int flex = 1});
  /// Applies opacity to this widget.
  ///
  /// Parameters:
  /// - [opacity] (`double`, required): Opacity value (0.0 to 1.0).
  ///
  /// Returns: `Widget` — widget with opacity.
  Widget withOpacity(double opacity);
  /// Clips this widget to a rectangle.
  ///
  /// Parameters:
  /// - [clipBehavior] (`Clip`, default: `Clip.hardEdge`): Clipping behavior.
  ///
  /// Returns: `Widget` — clipped widget.
  Widget clip({Clip clipBehavior = Clip.hardEdge});
  /// Clips this widget to a rounded rectangle.
  ///
  /// Parameters:
  /// - [borderRadius] (`BorderRadiusGeometry`, default: `BorderRadius.zero`): Corner radii.
  /// - [clipBehavior] (`Clip`, default: `Clip.antiAlias`): Clipping behavior.
  ///
  /// Returns: `Widget` — clipped widget.
  Widget clipRRect({BorderRadiusGeometry borderRadius = BorderRadius.zero, Clip clipBehavior = Clip.antiAlias});
  /// Clips this widget to an oval shape.
  ///
  /// Parameters:
  /// - [clipBehavior] (`Clip`, default: `Clip.antiAlias`): Clipping behavior.
  ///
  /// Returns: `Widget` — clipped widget.
  Widget clipOval({Clip clipBehavior = Clip.antiAlias});
  /// Clips this widget to a custom path.
  ///
  /// Parameters:
  /// - [clipBehavior] (`Clip`, default: `Clip.antiAlias`): Clipping behavior.
  /// - [clipper] (`CustomClipper<Path>`, required): Custom clipper for the path.
  ///
  /// Returns: `Widget` — clipped widget.
  Widget clipPath({Clip clipBehavior = Clip.antiAlias, required CustomClipper<Path> clipper});
  /// Applies a transformation matrix to this widget.
  ///
  /// Parameters:
  /// - [key] (`Key?`, optional): Widget key.
  /// - [transform] (`Matrix4`, required): Transformation matrix.
  ///
  /// Returns: `Widget` — transformed widget.
  Widget transform({Key? key, required Matrix4 transform});
  /// Sizes this widget to its intrinsic width.
  ///
  /// Parameters:
  /// - [stepWidth] (`double?`, optional): Stepping for width.
  /// - [stepHeight] (`double?`, optional): Stepping for height.
  ///
  /// Returns: `Widget` — intrinsically sized widget.
  Widget intrinsicWidth({double? stepWidth, double? stepHeight});
  /// Sizes this widget to its intrinsic height.
  ///
  /// Returns: `Widget` — intrinsically sized widget.
  Widget intrinsicHeight();
  /// Sizes this widget to both intrinsic width and height.
  ///
  /// Parameters:
  /// - [stepWidth] (`double?`, optional): Stepping for width.
  /// - [stepHeight] (`double?`, optional): Stepping for height.
  ///
  /// Returns: `Widget` — intrinsically sized widget.
  Widget intrinsic({double? stepWidth, double? stepHeight});
}
```
