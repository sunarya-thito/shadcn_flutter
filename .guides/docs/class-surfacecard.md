---
title: "Class: SurfaceCard"
description: "Reference for SurfaceCard"
---

```dart
class SurfaceCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final bool? filled;
  final Color? fillColor;
  final BorderRadiusGeometry? borderRadius;
  final Color? borderColor;
  final double? borderWidth;
  final Clip? clipBehavior;
  final List<BoxShadow>? boxShadow;
  final double? surfaceOpacity;
  final double? surfaceBlur;
  final Duration? duration;
  const SurfaceCard({super.key, required this.child, this.padding, this.filled, this.fillColor, this.borderRadius, this.clipBehavior, this.borderColor, this.borderWidth, this.boxShadow, this.surfaceOpacity, this.surfaceBlur, this.duration});
  Widget build(BuildContext context);
}
```
