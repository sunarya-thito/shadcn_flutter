---
title: "Class: WidgetStatesProvider"
description: "Reference for WidgetStatesProvider"
---

```dart
class WidgetStatesProvider extends StatelessWidget {
  final WidgetStatesController? controller;
  final Set<WidgetState>? states;
  final Widget child;
  final bool inherit;
  final bool boundary;
  const WidgetStatesProvider({super.key, this.controller, required this.child, this.states = const {}, this.inherit = true});
  const WidgetStatesProvider.boundary({super.key, required this.child});
  Widget build(BuildContext context);
}
```
