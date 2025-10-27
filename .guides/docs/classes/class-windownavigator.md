---
title: "Class: WindowNavigator"
description: "Reference for WindowNavigator"
---

```dart
class WindowNavigator extends StatefulWidget {
  final List<Window> initialWindows;
  final Widget? child;
  final bool showTopSnapBar;
  const WindowNavigator({super.key, required this.initialWindows, this.child, this.showTopSnapBar = true});
  State<WindowNavigator> createState();
}
```
