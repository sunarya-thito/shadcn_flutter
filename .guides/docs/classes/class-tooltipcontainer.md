---
title: "Class: TooltipContainer"
description: "A styled container widget for tooltip content."
---

```dart
/// A styled container widget for tooltip content.
///
/// Provides consistent visual styling for tooltip popups with customizable
/// background, opacity, blur, padding, and border radius. Integrates with
/// the tooltip theme system while allowing per-instance overrides.
class TooltipContainer extends StatelessWidget {
  /// The tooltip content widget.
  final Widget child;
  /// Opacity applied to the background surface (0.0 to 1.0).
  final double? surfaceOpacity;
  /// Blur radius applied to the background surface.
  final double? surfaceBlur;
  /// Padding around the tooltip content.
  final EdgeInsetsGeometry? padding;
  /// Background color of the tooltip container.
  final Color? backgroundColor;
  /// Border radius for rounded corners.
  final BorderRadiusGeometry? borderRadius;
  /// Creates a [TooltipContainer].
  ///
  /// All styling parameters are optional and fall back to theme defaults.
  ///
  /// Parameters:
  /// - [child] (`Widget`, required): Content to display in the tooltip.
  /// - [surfaceOpacity] (`double?`, optional): Background opacity (0.0-1.0).
  /// - [surfaceBlur] (`double?`, optional): Background blur radius.
  /// - [padding] (`EdgeInsetsGeometry?`, optional): Content padding.
  /// - [backgroundColor] (`Color?`, optional): Background color.
  /// - [borderRadius] (`BorderRadiusGeometry?`, optional): Border radius.
  ///
  /// Example:
  /// ```dart
  /// TooltipContainer(
  ///   surfaceOpacity: 0.9,
  ///   padding: EdgeInsets.all(8),
  ///   backgroundColor: Colors.black,
  ///   borderRadius: BorderRadius.circular(4),
  ///   child: Text('Tooltip text'),
  /// )
  /// ```
  const TooltipContainer({super.key, this.surfaceOpacity, this.surfaceBlur, this.padding, this.backgroundColor, this.borderRadius, required this.child});
  /// Builds the tooltip container.
  ///
  /// This allows using the widget as a builder function.
  Widget call(BuildContext context);
  Widget build(BuildContext context);
}
```
