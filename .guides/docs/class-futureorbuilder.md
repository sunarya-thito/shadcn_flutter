---
title: "Class: FutureOrBuilder"
description: "Reference for FutureOrBuilder"
---

```dart
class FutureOrBuilder<T> extends StatelessWidget {
  final FutureOr<T> future;
  final FutureOrWidgetBuilder<T> builder;
  final T? initialValue;
  const FutureOrBuilder({super.key, required this.future, required this.builder, this.initialValue});
  Widget build(BuildContext context);
}
```
