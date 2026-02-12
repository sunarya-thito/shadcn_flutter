---
title: "Class: DensityGap"
description: "A gap widget that resolves spacing using density settings.   Use this instead of [Gap] when you want spacing to adapt to density.  The [gap] value is a multiplier applied to [Density.baseGap].   Example:  ```dart  Column(    children: [      Text('First'),      DensityGap(gap: gapLg),  // Gap adapts to density      Text('Second'),    ],  )  ```"
---

```dart
/// A gap widget that resolves spacing using density settings.
///
/// Use this instead of [Gap] when you want spacing to adapt to density.
/// The [gap] value is a multiplier applied to [Density.baseGap].
///
/// Example:
/// ```dart
/// Column(
///   children: [
///     Text('First'),
///     DensityGap(gap: gapLg),  // Gap adapts to density
///     Text('Second'),
///   ],
/// )
/// ```
class DensityGap extends StatelessWidget {
  /// The gap multiplier, applied to [Density.baseGap].
  final double gap;
  /// Creates a [DensityGap].
  ///
  /// Parameters:
  /// - [gap] (`double`, required): Gap multiplier (use constants like [gapLg]).
  const DensityGap(this.gap, {super.key});
  Widget build(BuildContext context);
}
```
