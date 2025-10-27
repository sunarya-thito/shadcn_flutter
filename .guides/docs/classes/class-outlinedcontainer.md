---
title: "Class: OutlinedContainer"
description: "Reference for OutlinedContainer"
---

```dart
class OutlinedContainer extends StatefulWidget {
  final Widget child;
  final Color? backgroundColor;
  final Color? borderColor;
  final Clip clipBehavior;
  final BorderRadiusGeometry? borderRadius;
  final BorderStyle? borderStyle;
  final double? borderWidth;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry? padding;
  final double? surfaceOpacity;
  final double? surfaceBlur;
  final double? width;
  final double? height;
  final Duration? duration;
  const OutlinedContainer({super.key, required this.child, this.borderColor, this.backgroundColor, this.clipBehavior = Clip.antiAlias, this.borderRadius, this.borderStyle, this.borderWidth, this.boxShadow, this.padding, this.surfaceOpacity, this.surfaceBlur, this.width, this.height, this.duration});
  State<OutlinedContainer> createState();
}
```
