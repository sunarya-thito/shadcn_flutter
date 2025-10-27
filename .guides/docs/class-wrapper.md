---
title: "Class: Wrapper"
description: "Reference for Wrapper"
---

```dart
class Wrapper extends StatefulWidget {
  final Widget child;
  final WrapperBuilder? builder;
  final bool wrap;
  final bool maintainStructure;
  const Wrapper({super.key, required this.child, this.builder, this.wrap = true, this.maintainStructure = false});
  State<Wrapper> createState();
}
```
