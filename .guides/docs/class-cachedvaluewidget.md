---
title: "Class: CachedValueWidget"
description: "Reference for CachedValueWidget"
---

```dart
class CachedValueWidget<T> extends StatefulWidget {
  final T value;
  final Widget Function(BuildContext context, T value) builder;
  const CachedValueWidget({super.key, required this.value, required this.builder});
  State<StatefulWidget> createState();
}
```
