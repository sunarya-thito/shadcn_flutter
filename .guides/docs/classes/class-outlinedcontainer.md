---
title: "Class: OutlinedContainer"
description: "A container widget with customizable border and surface effects."
---

```dart
/// A container widget with customizable border and surface effects.
///
/// Provides a styled container with border, background, shadows, padding,
/// and optional surface blur effects. Supports theming and animations.
///
/// Example:
/// ```dart
/// OutlinedContainer(
///   borderRadius: BorderRadius.circular(12),
///   borderColor: Colors.blue,
///   backgroundColor: Colors.white,
///   padding: EdgeInsets.all(16),
///   child: Text('Outlined content'),
/// )
/// ```
class OutlinedContainer extends StatefulWidget {
  /// The child widget to display inside the container.
  final Widget child;
  /// Background color of the container.
  ///
  /// If `null`, uses theme default.
  final Color? backgroundColor;
  /// Color of the container's border.
  ///
  /// If `null`, uses theme default.
  final Color? borderColor;
  /// How to clip the container's content.
  ///
  /// Defaults to [Clip.antiAlias].
  final Clip clipBehavior;
  /// Border radius for rounded corners.
  ///
  /// If `null`, uses theme default.
  final BorderRadiusGeometry? borderRadius;
  /// Style of the border.
  ///
  /// If `null`, uses [BorderStyle.solid].
  final BorderStyle? borderStyle;
  /// Width of the border in logical pixels.
  ///
  /// If `null`, uses theme default.
  final double? borderWidth;
  /// Box shadows for elevation effects.
  ///
  /// If `null`, no shadows are applied.
  final List<BoxShadow>? boxShadow;
  /// Padding inside the container.
  ///
  /// If `null`, uses theme default.
  final EdgeInsetsGeometry? padding;
  /// Opacity for surface overlay effects.
  ///
  /// If provided, modulates the background color's alpha.
  final double? surfaceOpacity;
  /// Blur amount for surface backdrop effects.
  ///
  /// If `null` or `<= 0`, no blur is applied.
  final double? surfaceBlur;
  /// Explicit width of the container.
  ///
  /// If `null`, size is determined by child and padding.
  final double? width;
  /// Explicit height of the container.
  ///
  /// If `null`, size is determined by child and padding.
  final double? height;
  /// Duration for animating property changes.
  ///
  /// If `null`, changes are applied immediately without animation.
  final Duration? duration;
  /// Creates an [OutlinedContainer].
  const OutlinedContainer({super.key, required this.child, this.borderColor, this.backgroundColor, this.clipBehavior = Clip.antiAlias, this.borderRadius, this.borderStyle, this.borderWidth, this.boxShadow, this.padding, this.surfaceOpacity, this.surfaceBlur, this.width, this.height, this.duration});
  State<OutlinedContainer> createState();
}
```
