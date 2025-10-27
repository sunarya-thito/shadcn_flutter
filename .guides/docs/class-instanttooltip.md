---
title: "Class: InstantTooltip"
description: "Reference for InstantTooltip"
---

```dart
class InstantTooltip extends StatefulWidget {
  final Widget child;
  final HitTestBehavior behavior;
  final WidgetBuilder tooltipBuilder;
  final AlignmentGeometry tooltipAlignment;
  final AlignmentGeometry? tooltipAnchorAlignment;
  const InstantTooltip({super.key, required this.child, required this.tooltipBuilder, this.behavior = HitTestBehavior.translucent, this.tooltipAlignment = Alignment.bottomCenter, this.tooltipAnchorAlignment});
  State<InstantTooltip> createState();
}
```
