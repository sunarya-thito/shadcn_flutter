---
title: "Class: ShadcnAnimatedTheme"
description: "Reference for ShadcnAnimatedTheme"
---

```dart
class ShadcnAnimatedTheme extends StatelessWidget {
  final Widget child;
  final ThemeData data;
  final Duration duration;
  final Curve curve;
  final VoidCallback? onEnd;
  const ShadcnAnimatedTheme({super.key, required this.data, required this.duration, this.curve = Curves.linear, this.onEnd, required this.child});
  Widget build(BuildContext context);
}
```
