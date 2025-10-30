---
title: "Class: AdaptiveScaler"
description: "A widget that applies adaptive scaling to its descendants."
---

```dart
/// A widget that applies adaptive scaling to its descendants.
class AdaptiveScaler extends StatelessWidget {
  /// Gets the default adaptive scaling for the current context.
  ///
  /// Returns [AdaptiveScaling.mobile] for iOS/Android platforms,
  /// [AdaptiveScaling.desktop] for other platforms.
  static AdaptiveScaling defaultScalingOf(BuildContext context);
  /// Gets the default adaptive scaling for the given theme.
  ///
  /// Returns [AdaptiveScaling.mobile] for iOS/Android platforms,
  /// [AdaptiveScaling.desktop] for other platforms.
  static AdaptiveScaling defaultScaling(ThemeData theme);
  /// The scaling to apply.
  final AdaptiveScaling scaling;
  /// The widget below this widget in the tree.
  final Widget child;
  /// Creates an [AdaptiveScaler].
  ///
  /// Parameters:
  /// - [scaling] (`AdaptiveScaling`, required): Scaling factors to apply.
  /// - [child] (`Widget`, required): Child widget.
  const AdaptiveScaler({super.key, required this.scaling, required this.child});
  Widget build(BuildContext context);
}
```
