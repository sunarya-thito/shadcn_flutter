---
title: "Class: TooltipContainer"
description: "Reference for TooltipContainer"
---

```dart
class TooltipContainer extends StatelessWidget {
  final Widget child;
  final double? surfaceOpacity;
  final double? surfaceBlur;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  const TooltipContainer({super.key, this.surfaceOpacity, this.surfaceBlur, this.padding, this.backgroundColor, this.borderRadius, required this.child});
  Widget call(BuildContext context);
  Widget build(BuildContext context);
}
```
