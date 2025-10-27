---
title: "Class: SeparatedFlex"
description: "Reference for SeparatedFlex"
---

```dart
class SeparatedFlex extends StatefulWidget {
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;
  final List<Widget> children;
  final Axis direction;
  final Widget separator;
  final Clip clipBehavior;
  const SeparatedFlex({super.key, required this.mainAxisAlignment, required this.mainAxisSize, required this.crossAxisAlignment, this.textDirection, required this.verticalDirection, this.textBaseline, required this.children, required this.separator, required this.direction, this.clipBehavior = Clip.none});
  State<SeparatedFlex> createState();
}
```
