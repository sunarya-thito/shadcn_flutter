---
title: "Class: Validated"
description: "Reference for Validated"
---

```dart
class Validated<T> extends StatefulWidget {
  final ValidatedBuilder builder;
  final Validator<T> validator;
  final Widget? child;
  const Validated({super.key, required this.builder, required this.validator, this.child});
  State<Validated> createState();
}
```
