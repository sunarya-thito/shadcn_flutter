---
title: "Class: DensityContainerPadding"
description: "A padding widget that resolves density insets using container padding base.   Use this for widgets that contain multiple children (cards, dialogs, panels).  The padding is resolved using [Density.baseContainerPadding].   Example:  ```dart  DensityContainerPadding(    padding: const DirectionalEdgeInsetsDensity.all(padLg),    child: Column(children: [...]),  )  ```"
---

```dart
/// A padding widget that resolves density insets using container padding base.
///
/// Use this for widgets that contain multiple children (cards, dialogs, panels).
/// The padding is resolved using [Density.baseContainerPadding].
///
/// Example:
/// ```dart
/// DensityContainerPadding(
///   padding: const DirectionalEdgeInsetsDensity.all(padLg),
///   child: Column(children: [...]),
/// )
/// ```
class DensityContainerPadding extends StatelessWidget {
  /// The padding to apply, can be density-aware or absolute.
  final EdgeInsetsGeometry padding;
  /// The child widget to apply padding to.
  final Widget child;
  /// Creates a [DensityContainerPadding].
  ///
  /// Parameters:
  /// - [padding] (`EdgeInsetsGeometry`, required): The padding specification.
  /// - [child] (`Widget`, required): The child to wrap with padding.
  const DensityContainerPadding({super.key, required this.padding, required this.child});
  Widget build(BuildContext context);
}
```
