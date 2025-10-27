---
title: "Class: ClickDetector"
description: "Reference for ClickDetector"
---

```dart
class ClickDetector extends StatefulWidget {
  final ClickCallback<ClickDetails>? onClick;
  final Widget child;
  final HitTestBehavior behavior;
  final Duration threshold;
  const ClickDetector({super.key, this.onClick, required this.child, this.behavior = HitTestBehavior.deferToChild, this.threshold = const Duration(milliseconds: 300)});
  State<ClickDetector> createState();
}
```
