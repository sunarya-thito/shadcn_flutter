---
title: "Class: ConvertedController"
description: "Reference for ConvertedController"
---

```dart
class ConvertedController<F, T> extends ChangeNotifier implements ComponentController<T> {
  ConvertedController(ValueNotifier<F> other, BiDirectionalConvert<F, T> convert);
  T get value;
  set value(T newValue);
  void dispose();
}
```
