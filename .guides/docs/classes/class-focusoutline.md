---
title: "Class: FocusOutline"
description: "A widget that displays a visual outline when focused."
---

```dart
/// A widget that displays a visual outline when focused.
///
/// Wraps a child widget with a customizable border that appears when the
/// [focused] property is true. Commonly used to indicate keyboard focus state
/// for interactive elements.
///
/// Example:
/// ```dart
/// FocusOutline(
///   focused: hasFocus,
///   borderRadius: BorderRadius.circular(8),
///   child: TextButton(
///     onPressed: () {},
///     child: Text('Focused Button'),
///   ),
/// )
/// ```
class FocusOutline extends StatelessWidget {
  /// The child widget to wrap with the focus outline.
  final Widget child;
  /// Whether to display the focus outline.
  ///
  /// When `true`, the outline is visible. When `false`, it's hidden.
  final bool focused;
  /// Border radius for the focus outline corners.
  ///
  /// If `null`, uses the default from [FocusOutlineTheme].
  final BorderRadiusGeometry? borderRadius;
  /// Alignment offset for positioning the outline.
  ///
  /// If `null`, uses the default from [FocusOutlineTheme].
  final double? align;
  /// The border style for the outline.
  ///
  /// If `null`, uses the default from [FocusOutlineTheme].
  final Border? border;
  /// The shape of the outline.
  ///
  /// Can be [BoxShape.rectangle] or [BoxShape.circle].
  final BoxShape? shape;
  /// Creates a [FocusOutline].
  ///
  /// Parameters:
  /// - [child] (`Widget`, required): Widget to wrap.
  /// - [focused] (`bool`, required): Whether to show the outline.
  /// - [borderRadius] (`BorderRadiusGeometry?`, optional): Corner rounding.
  /// - [align] (`double?`, optional): Outline offset.
  /// - [border] (`Border?`, optional): Border style.
  /// - [shape] (`BoxShape?`, optional): Outline shape.
  const FocusOutline({super.key, required this.child, required this.focused, this.borderRadius, this.align, this.border, this.shape});
  Widget build(BuildContext context);
}
```
