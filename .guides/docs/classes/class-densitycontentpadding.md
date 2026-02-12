---
title: "Class: DensityContentPadding"
description: "A padding widget that resolves density insets using content padding base.   Use this for widgets that contain content (buttons, text fields, chips).  The padding is resolved using [Density.baseContentPadding].   Example:  ```dart  DensityContentPadding(    padding: const DirectionalEdgeInsetsDensity.symmetric(      horizontal: padLg,      vertical: padSm,    ),    child: Text('Button content'),  )  ```"
---

```dart
/// A padding widget that resolves density insets using content padding base.
///
/// Use this for widgets that contain content (buttons, text fields, chips).
/// The padding is resolved using [Density.baseContentPadding].
///
/// Example:
/// ```dart
/// DensityContentPadding(
///   padding: const DirectionalEdgeInsetsDensity.symmetric(
///     horizontal: padLg,
///     vertical: padSm,
///   ),
///   child: Text('Button content'),
/// )
/// ```
class DensityContentPadding extends StatelessWidget {
  /// The padding to apply, can be density-aware or absolute.
  final EdgeInsetsGeometry padding;
  /// The child widget to apply padding to.
  final Widget child;
  /// Creates a [DensityContentPadding].
  ///
  /// Parameters:
  /// - [padding] (`EdgeInsetsGeometry`, required): The padding specification.
  /// - [child] (`Widget`, required): The child to wrap with padding.
  const DensityContentPadding({super.key, required this.padding, required this.child});
  Widget build(BuildContext context);
}
```
