---
title: "Class: ConvertedController"
description: "A controller that converts between types [F] and [T]."
---

```dart
/// A controller that converts between types [F] and [T].
///
/// Maintains bidirectional synchronization between two value notifiers
/// with different types using a [BiDirectionalConvert].
class ConvertedController<F, T> extends ChangeNotifier implements ComponentController<T> {
  /// Creates a [ConvertedController].
  ///
  /// Parameters:
  /// - [other] (`ValueNotifier<F>`, required): Source value notifier.
  /// - [convert] (`BiDirectionalConvert<F, T>`, required): Bidirectional converter.
  ConvertedController(ValueNotifier<F> other, BiDirectionalConvert<F, T> convert);
  T get value;
  set value(T newValue);
  void dispose();
}
```
