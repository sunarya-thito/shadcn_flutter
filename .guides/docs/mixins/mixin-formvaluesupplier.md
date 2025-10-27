---
title: "Mixin: FormValueSupplier"
description: "Reference for FormValueSupplier"
---

```dart
mixin FormValueSupplier<T, X extends StatefulWidget> on State<X> {
  T? get formValue;
  set formValue(T? value);
  void didChangeDependencies();
  void didReplaceFormValue(T value);
}
```
