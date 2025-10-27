---
title: "Class: ResizablePane"
description: "Reference for ResizablePane"
---

```dart
class ResizablePane extends StatefulWidget {
  final ResizablePaneController? controller;
  final double? initialSize;
  final double? initialFlex;
  final double? minSize;
  final double? maxSize;
  final double? collapsedSize;
  final Widget child;
  final ValueChanged<double>? onSizeChangeStart;
  final ValueChanged<double>? onSizeChange;
  final ValueChanged<double>? onSizeChangeEnd;
  final ValueChanged<double>? onSizeChangeCancel;
  final bool? initialCollapsed;
  const ResizablePane({super.key, required double this.initialSize, this.minSize, this.maxSize, this.collapsedSize, required this.child, this.onSizeChangeStart, this.onSizeChange, this.onSizeChangeEnd, this.onSizeChangeCancel, bool this.initialCollapsed = false});
  const ResizablePane.flex({super.key, double this.initialFlex = 1, this.minSize, this.maxSize, this.collapsedSize, required this.child, this.onSizeChangeStart, this.onSizeChange, this.onSizeChangeEnd, this.onSizeChangeCancel, bool this.initialCollapsed = false});
  const ResizablePane.controlled({super.key, required ResizablePaneController this.controller, this.minSize, this.maxSize, this.collapsedSize, required this.child, this.onSizeChangeStart, this.onSizeChange, this.onSizeChangeEnd, this.onSizeChangeCancel});
  State<ResizablePane> createState();
}
```
