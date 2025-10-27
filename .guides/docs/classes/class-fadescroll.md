---
title: "Class: FadeScroll"
description: "Reference for FadeScroll"
---

```dart
class FadeScroll extends StatelessWidget {
  final double? startOffset;
  final double? endOffset;
  final double startCrossOffset;
  final double endCrossOffset;
  final Widget child;
  final ScrollController controller;
  final List<Color>? gradient;
  const FadeScroll({super.key, this.startOffset, this.endOffset, required this.child, required this.controller, this.gradient, this.startCrossOffset = 0, this.endCrossOffset = 0});
  Widget build(BuildContext context);
}
```
