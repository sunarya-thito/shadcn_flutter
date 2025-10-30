---
title: "Class: GradientAngleGeometry"
description: "Reference for GradientAngleGeometry"
---

```dart
abstract class GradientAngleGeometry {
  const GradientAngleGeometry();
  double get angle;
  AlignmentGeometry get begin;
  AlignmentGeometry get end;
  DirectionalGradientAngle toDirectional();
  GradientAngle toNonDirectional();
}
```
