---
title: "Class: AdaptiveScaler"
description: "Reference for AdaptiveScaler"
---

```dart
class AdaptiveScaler extends StatelessWidget {
  static AdaptiveScaling defaultScalingOf(BuildContext context);
  static AdaptiveScaling defaultScaling(ThemeData theme);
  final AdaptiveScaling scaling;
  final Widget child;
  const AdaptiveScaler({super.key, required this.scaling, required this.child});
  Widget build(BuildContext context);
}
```
